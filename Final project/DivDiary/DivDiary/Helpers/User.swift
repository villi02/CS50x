//
//  User.swift
//  DivDiary
//
//  Created by Villi Arnar on 11/06/2022.
//

import Foundation

struct User{
    
    static var email: String = ""
    static var password: String = ""
    static var uid: String = ""
    static var portfolio: [Stock] = []

    init( email_user: String, password_user: String, uid_user: String, portfolio_User: [Stock]) {
        
        User.email = email_user
        User.password = password_user
        User.uid = uid_user
        User.portfolio = portfolio_User
    }
}




