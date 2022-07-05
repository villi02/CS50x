//
//  AccountViewController.swift
//  DivDiary
//
//  Created by Villi Arnar on 10/06/2022.
//

import Foundation
import FirebaseCore
import UIKit

class AccountViewController: UIViewController {
 
    @IBOutlet weak var UsernameLabel: UILabel!
    
    @IBOutlet weak var EmailLabel: UILabel!
    
    @IBOutlet weak var PasswordLabel: UILabel!

    @IBOutlet weak var ChangeUsernameButton: UIButton!

    @IBOutlet weak var ChangeEmailButton: UIButton!
    
    @IBOutlet weak var ChangePasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemGray
        
        UsernameLabel.text = "Hello there"
        EmailLabel.text = User.email
        PasswordLabel.text = User.password
    }
    
    func transitionToStartScreen() {
        let homeViewController =  storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.startViewController) as? UINavigationController
        
        view.window?.rootViewController = homeViewController
        view?.window?.makeKeyAndVisible()
        
    }
    
    
    // Function will make a popup appear to change username
    @IBAction func ChangeUserTapped(_ sender: Any) {
        // Todo
    }
    
    // Function will make a popup appear to change email
    @IBAction func ChangeEmailTapped(_ sender: Any) {
        // Todo
    }
    
    // Function will make a popup appear to change password
    @IBAction func ChangePasswordTapped(_ sender: Any) {
        // Todo
    }
    
    @IBAction func LogOutTapped(_ sender: Any) {
        User.email = ""
        User.password = ""
        User.uid = ""
        User.portfolio = []
        
        self.transitionToStartScreen()
    }
    
}
