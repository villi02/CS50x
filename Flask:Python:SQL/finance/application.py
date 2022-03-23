import os

from cs50 import SQL
from datetime import datetime
import time
from flask import Flask, flash, redirect, render_template, request, session, jsonify
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.exceptions import default_exceptions, HTTPException, InternalServerError
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True


# Ensure responses aren't cached
@app.after_request
def after_request(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_FILE_DIR"] = mkdtemp()
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"):
    raise RuntimeError("API_KEY not set")


@app.route("/addcash", methods=["GET", "POST"])
@login_required
def addcash():
    if request.method == "POST":
        cash = request.form.get("cash", type=int)
        initialcash = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])[0]["cash"]
        newcash = initialcash + cash
        
        # Change the users cash
        db.execute("UPDATE users SET cash = ? WHERE id=?", newcash, session["user_id"])
        
        return redirect("/")

    else:
        return render_template("addcash.html")


@app.route("/")
@login_required
def index():
    stockprice = {}
    stockname = {}
    portfolio = db.execute("SELECT * FROM ownership WHERE userID = ?", session["user_id"])
    user = db.execute("SELECT * FROM users WHERE id = ?", session["user_id"])
    for stock in portfolio:
        stockname[stock["stock"]] = lookup(stock["stock"])["name"]
        stockprice[stock["stock"]] = lookup(stock["stock"])["price"]

    return render_template("index.html", stockname=stockname, stockprice=stockprice, portfolio=portfolio, user=user)


# personal touch idea, add a view history!
@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    if request.method == "POST":
        # Ensure stock is provided and valid
        if not request.form.get("symbol"):
            return apology("Must provide stock symbol", 69)
            
        if lookup(request.form.get("symbol")) is None:
            return apology("Invalid stock symbol")
            
        # Ensure amount of shares is provided
        elif not request.form.get("shares"):
            return apology("Must provide amount of shares", 69)

        # Ensure amount of shares is a positiv integer
        elif not request.form.get("shares", type=int) > 0:
            return apology("Must provide a positiv integer")
            
        # Initialize values for later use
        shares = request.form.get("shares", type=int)
        initialcash = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])[0]["cash"]
        stock = lookup(request.form.get("symbol"))
        priceShares = stock["price"] * shares
        newcash = initialcash - priceShares
        
        # Check if there is enough cash for transaction
        if not (initialcash - priceShares) > 0:
            return apology("You do not have the funds required to make this transaction")

        # Change the users cash
        db.execute("UPDATE users SET cash = ? WHERE id=?", (initialcash - priceShares), session["user_id"])
        
        # Insert the stock into the users portfolio
        if not db.execute("SELECT * FROM ownership WHERE userID= ? AND stock = ?", session["user_id"], request.form.get("symbol")):
            db.execute("INSERT INTO ownership (userID, stock, shares) VALUES(?, ?, ?)", 
                       session["user_id"], request.form.get("symbol"), shares)
        else:
            newshares = db.execute("SELECT shares FROM ownership WHERE userID = ? AND stock = ?", 
                                   session["user_id"], request.form.get("symbol"))[0]["shares"] + shares
            db.execute("UPDATE ownership SET shares = ? WHERE userID = ? AND stock = ? ",
                       newshares, session["user_id"], request.form.get("symbol"))
        # Update the users transaction history
        db.execute("INSERT INTO history (userID, symbol, price, amount, action, date, totalprice) VALUES(?, ?, ?, ?, ?, ?, ?)", 
                   session["user_id"], request.form.get("symbol"), stock["price"], shares, "buy", datetime.now(), priceShares)

        return redirect("/")

    else:
        return render_template("buy.html")


@app.route("/history")
@login_required
def history():
    stockname = {}
    history = db.execute("SELECT * FROM history WHERE userID = ?", session["user_id"])
    for stock in history:
        stockname[stock["symbol"]] = lookup(stock["symbol"])["name"]
        
    return render_template("history.html", history=history, stockname=stockname)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    if request.method == "POST":
        if not request.form.get("symbol"):
            return apology("Must imput stock symbol")
        if lookup(request.form.get("symbol")) is None:
            return apology("Invalid stock symbol")
        
        return render_template("quoteresult.html", stock=lookup(request.form.get("symbol")))
    else:
        return render_template("quote.html")


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        
        usernamecheck = db.execute("SELECT * FROM users WHERE username = ?", request.form.get("username"))
        
        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 400)
        
        # Ensure username is not taken
        elif len(usernamecheck) != 0:
            return apology("Username already taken")

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 400)

        # Ensure password comformation was submitted
        elif not request.form.get("confirmation"):
            return apology("must provide confirmation password", 400)

        # Ensure password and password confirmation match exactly
        elif request.form.get("password") != request.form.get("confirmation"):
            return apology("password and confirmation password must match exactly")

        # Register new user into the database
        db.execute("INSERT INTO users (username, hash) VALUES(?, ?)",
                   (request.form.get("username")), generate_password_hash(request.form.get("password")))

        return redirect("/")

    else:
        return render_template("register.html")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    # Initialize portfolio
    portfolio = db.execute("SELECT * FROM ownership WHERE userID = ?", session["user_id"])
    if request.method == "POST":
        
        # Endsure stock was submitted
        if not request.form.get("symbol"):
            return apology("Must submit a stock")
        
        # Ensure shares was submitted
        elif not request.form.get("shares"):
            return apology("Must submit amount of shares")
            
        # Ensure shares submitted is positive integer
        elif not request.form.get("shares", type=int) > 0:
            return apology("Must be a positive integer")
        
        # Ensure the user owns the selected stock
        elif not any(stock["stock"] == request.form.get("symbol") for stock in portfolio):
            return apology("you do not own this stock")
        
        pickedshare = db.execute("SELECT * FROM ownership WHERE userID = ? AND stock = ?",
                                 session["user_id"], request.form.get("symbol"))
        
        # Ensure the user owns enough shares
        if not pickedshare[0]["shares"] >= request.form.get("shares", type=int):
            return apology("Not enough shares to complete transaction") 
            
        # Initialize values for later use
        shares = request.form.get("shares", type=int)
        initialcash = db.execute("SELECT cash FROM users WHERE id = ?", session["user_id"])[0]["cash"]
        stock = lookup(request.form.get("symbol"))
        priceShares = stock["price"] * shares
        newcash = initialcash + priceShares
        
        # Change portfolio, and delete share from portfolio if user sells all shares
        newshares = pickedshare[0]["shares"] - shares
        if newshares == 0:
            db.execute("DELETE FROM ownership WHERE userID = ? AND stock = ?", session["user_id"], request.form.get("symbol"))
        else:
            db.execute("UPDATE ownership SET shares = ? WHERE userID = ? AND stock = ? ",
                       newshares, session["user_id"], request.form.get("symbol"))
        
        # Update the users cash
        db.execute("UPDATE users SET cash = ? WHERE id=?", (initialcash + priceShares), session["user_id"])
        
        # Update the users transaction history
        db.execute("INSERT INTO history (userID, symbol, price, amount, action, date, totalprice) VALUES(?, ?, ?, ?, ?, ?, ?)",
                   session["user_id"], request.form.get("symbol"), stock["price"], shares, "sell", datetime.now(), priceShares)
        
        return redirect("/")
        
    else:
        return render_template("sell.html", portfolio=portfolio)


def errorhandler(e):
    """Handle error"""
    if not isinstance(e, HTTPException):
        e = InternalServerError()
    return apology(e.name, e.code)


# Listen for errors
for code in default_exceptions:
    app.errorhandler(code)(errorhandler) 
