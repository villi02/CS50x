
import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        // Hides the error label
        errorLabel.alpha = 0
    }
    
    func transitionToHomescreen() {
        
        let homeViewController =  storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarViewController) as? UITabBarController
        
        view.window?.rootViewController = homeViewController
        view?.window?.makeKeyAndVisible()
        
    }
    
    // A method to validate that all fields have an input
    func validateFields() -> String? {
    
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all the fields"
        }
            
        // Check if the password if secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        if Utilities.isPasswordValid(password: cleanedPassword) == false {
            //  Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character an a number"
            }
         
            return nil
        }
        
        func showError(_ message:String) {
            errorLabel.text = message
            errorLabel.alpha = 1
        }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let err = validateFields()
        
        if err != nil {
            showError(err!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            print("After this")
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                // Check for errors
                if error != nil {
                    // There was an error
                    print(error!)
                    self.showError("Error creating user")
                }
                else{
                    // User was created succesfully, now store first an last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid":result!.user.uid]){ (err) in
                        
                        if err != nil{
                            // Show error message
                            self.showError("User data couldn't")
                        }
                    }
                    // Transition to home screen
                    self.transitionToHomescreen()
                }
            }
            
        }
            
    }

}
