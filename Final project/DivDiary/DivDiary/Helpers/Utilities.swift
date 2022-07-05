//
//  Utilities.swift
//  DivDiary
//
//  Created by Villi Arnar on 25/05/2022.
//

import Foundation

class Utilities {
    
    static func isPasswordValid ( password : String) -> Bool{
        
        // Password length 8+, One alphabet character, one special character
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}

func loadUser() {
    
}
