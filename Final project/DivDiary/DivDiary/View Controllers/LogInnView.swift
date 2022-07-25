
import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseDatabaseSwift

class LogInnView: UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInnButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHomescreen() {
        
        let homeViewController =  storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarViewController) as? UITabBarController
        
        view.window?.rootViewController = homeViewController
        view?.window?.makeKeyAndVisible()
        
    }
    
    func setUpElements() {
        // Hides the error label
        errorLabel.alpha = 0
    }
    
    @IBAction func logInnTapped(_ sender: Any) {
        
        // Validate textfields
        
        //let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = "tester@tester.tester"
        let password = "tester1234*"
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            // Unable to sign in
            if error != nil {
                self.showError("Unable to sign in")
            }
            else{
                //testStockAPI(symbol: "AAPL")
                /*
                let userID = Auth.auth().currentUser?.uid
                var ref: DatabaseReference!
                
                print(userID!)

                ref = Database.database().reference()
                
                let actuallUID = "buUuCUD0gsJgzfthVmXM"
                
                print("First")
                ref?.child("users").child(userID!).observeSingleEvent(of: .value, with: {snapshot in
                    print(snapshot.value as! [String: AnyObject])
                })
                
                print("Second")
                ref.child("users").child(actuallUID).observeSingleEvent(of: .value, with: { snapshot in
                  // Get user value
                  let value = snapshot.value as? NSDictionary
                  let firstNm = value?["firstname"] as? String ?? "No first name found"
                    
                  // ...
                }) { error in
                  print(error.localizedDescription)
                }
                
                print("Third")
                ref.child("users/\(actuallUID)").getData(completion:  { error, snapshot in
                  guard error == nil else {
                    print(error!.localizedDescription)
                    return;
                  }
                    let userName = snapshot?.value as? String ?? "Unknown";
                    print("Should be first name", userName)
                });
                 */
                PortfolioManager.init()
                User.email = (Auth.auth().currentUser?.email)!
                
                /*
                User.init(email_user: currentUser.email, password_user: password, uid_user: currentUser.uid, portfolio_User: currentUser.portfo )
                 */
                var loadingtext = "waiting."
                while User.portfolio.isEmpty {
                    print(loadingtext)
                    loadingtext += "."
                }
                self.transitionToHomescreen()
                
            }
        }
    }
    
}


