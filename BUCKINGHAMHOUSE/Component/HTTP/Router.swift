//
//  Router.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 03/08/23.
//

import Foundation


enum Router: String {
    
    static let BASE_SERVICE_URL = "https://techimmense.in/BuckinghamHouse/webservice/"
    static let BASE_IMAGE_URL  = "https://techimmense.in/BuckinghamHouse/Upload/image"
    
    case LogIn
    case ForgotPassword
    
    case Otp
    
    case Profile
    case UpdateProfile
    
    case UpdatedPassword
    case cart
    
    case getPdfDocument
    case getvideos
    case getAdvertisement
    case getManagingAgent
    case getTermCondition
    
    case addMeterReading
    case addApartmentReport
    case addCleaningService
    case addCommonbooking
    
    case deleteAccount
    case StripePayment
    
    case addPayment
    
    public func url() -> String {
        switch self {
            
        case .LogIn:
            return Router.oAuthRoute(path: "login")
            
        case .ForgotPassword:
            return Router.oAuthRoute(path: "forgot_password")
            
        case .Profile:
            return Router.oAuthRoute(path: "get_profile")
            
        case .UpdateProfile:
            return Router.oAuthRoute(path: "user_update_profile")
            
        case .Otp:
            return Router.oAuthRoute(path: "verify_number")
            
        case .UpdatedPassword:
            return Router.oAuthRoute(path: "change_password")
            
        case .cart:
            return Router.oAuthRoute(path: "get_announcement_list")
            
        case .getManagingAgent:
            return Router.oAuthRoute(path: "get_agent_details")
            
        case .getvideos:
            return Router.oAuthRoute(path: "get_user_manuals")
            
        case .addCleaningService:
            return Router.oAuthRoute(path: "cleaner_request")
            
        case .addCommonbooking:
            return Router.oAuthRoute(path: "common_room_booking")
            
        case .addMeterReading:
            return Router.oAuthRoute(path: "add_meter_reading")
            
        case .addApartmentReport:
            return Router.oAuthRoute(path: "add_fault_report")
            
        case.StripePayment:
            return Router.oAuthRoute(path: "strip_payment_new")
            
        case .getPdfDocument:
            return Router.oAuthRoute(path: "get_docuements")
            
        case .getAdvertisement:
            return Router.oAuthRoute(path: "get_advertisement")
            
        case .getTermCondition:
            return Router.oAuthRoute(path: "get_user_page")
            
        case .deleteAccount:
            return Router.oAuthRoute(path: "delete_user_account")
            
        case .addPayment:
            return Router.oAuthRoute(path: "add_payment")
        
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}

