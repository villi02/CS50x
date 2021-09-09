-- Keep a log of any SQL queries you execute as you solve the mystery.

.tables

.schema crime_scene_reports

SELECT description FROM crime_scene_reports WHERE
month = 7 AND
day = 28 AND
street = "Chamberlin Street";

SELECT activity,  FROM courthouse_security_logs WHERE
month = 7 AND
day = 28;

SELECT transcript, name FROM interviews
WHERE month = 7 AND 
day = 28;

SELECT license_plate FROM courthouse_security_logs
WHERE month = 7
AND day = 28
AND hour = 10
AND minute >= 5
AND minute <= 25
AND activity = "exit";

SELECT name, license_plate FROM people 
WHERE license_plate IN (SELECT license_plate FROM courthouse_security_logs
WHERE month = 7
AND year = 2020
AND day = 28
AND hour = 10
AND minute >= 5
AND minute <= 25
AND activity = "exit");

SELECT account_number, amount FROM atm_transactions
WHERE month = 7
AND year = 2020
AND day = 28
AND atm_location = "Fifer Street"
AND transaction_type = "withdraw";

SELECT name, account_number FROM bank_accounts
JOIN people ON bank_accounts.person_id = people.id
WHERE account_number IN (SELECT account_number FROM atm_transactions
WHERE month = 7
AND year = 2020
AND day = 28
AND atm_location = "Fifer Street"
AND transaction_type = "withdraw");

SELECT caller FROM phone_calls
WHERE duration < 60
AND month = 7
AND day = 28;

SELECT city, hour FROM flights
JOIN airports ON flights.origin_airport_id = airports.id
WHERE city = "Fiftyville"
AND month = 7
AND day = 29;

SELECT destination_airport_id, flights.id FROM flights
JOIN airports ON flights.origin_airport_id = airports.id
WHERE city = "Fiftyville"
AND month = 7
AND day = 29
AND hour = 8;

SELECT city FROM airports
WHERE id = (SELECT destination_airport_id FROM flights
JOIN airports ON flights.origin_airport_id = airports.id
WHERE city = "Fiftyville"
AND month = 7
AND day = 29
AND hour = 8);


SELECT passport_number, name FROM people 
WHERE passport_number IN (
SELECT passport_number FROM flights
JOIN passengers ON flights.id = passengers.flight_id
WHERE id = 36);


SELECT name FROM phone_calls
JOIN people ON people.phone_number = phone_calls.caller
WHERE month = 7
AND day = 28
AND year = 2020
AND duration > 60;

SELECT name FROM people 
WHERE phone_number IN 
(
    SELECT receiver FROM phone_calls
    WHERE caller IN 
    (
        SELECT phone_number FROM people
        WHERE name = "Ernest"
    )
    AND month = 7
    AND day = 28
    AND year = 2020
    AND duration < 60
);

SELECT name FROM people
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
JOIN bank_accounts ON people.id = bank_accounts.person_id
WHERE amount = 50
AND month = 7
AND transaction_type = "withdraw";

SELECT duration FROM phone_calls 
   ...> WHERE caller = "(367) 555-5533"
   ...> AND day = 28;
   
SELECT name FROM people 
WHERE phone_number IN 
(
    SELECT receiver FROM phone_calls
    WHERE caller IN 
    (
        SELECT phone_number FROM people
        WHERE name = "Ernest"
    )
    AND month = 7
    AND day = 28
    AND year = 2020
    AND duration < 60
);
