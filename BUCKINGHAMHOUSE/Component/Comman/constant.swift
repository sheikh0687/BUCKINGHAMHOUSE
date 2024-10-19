//
//  constant.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 03/08/23.
//

import Foundation
import UIKit

struct k {
    
    static let appName                                      =      "Buckingham House"
    static var iosRegisterId                                =      "123456"
    static let emptyString                                  =      ""
    static let userDefault                                  =      UserDefaults.standard
    static let userType                                     =      "Type"
    static let currency                                     =      "$"
  
    
    
    struct languages
    {
        struct english
        {
            
            static let urlTermsCondition                    =      ""
            static let urlForgotPassword                    =      ""
            
        }
    }
    
    struct session {
        
        static let status                                   =      "status"
        static let userId                                   =      "user_id"
        static let userName                                 =      "user_name"
        static let userReferal                              =      "referral_code"
        static let userEmail                                =      "email"
        static let userLogin                                =      ""
        static let language                                 =      ""
        static let userImage                                =      "user_image"
        static let userType                                 =      "type"
        
        
    }
    
    struct google {
        static let googleApiKey                             =      ""
        static let googleClientId                           =      ""
    }
    
}
