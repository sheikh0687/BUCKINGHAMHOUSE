//
//  Api.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 03/08/23.
//

import Foundation
import UIKit

class Api: NSObject{
    
    static let shared = Api()
    
    func paramGetUserId() -> [String:AnyObject] {
        var dict : [String:AnyObject] = [:]
        dict["user_id"] = k.userDefault.string(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    func login(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : Reslogin) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.LogIn.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(getLogin.self, from: response)
                
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.hideProgressBar()
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                    k.userDefault.set(k.emptyString, forKey: k.session.userReferal)
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong")
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    
    func verifyOtp(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResOtp) -> Void) {
        vc.blockUi()
        Service.post(url: Router.Otp.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiVerifyOtp.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                }
                vc.unBlockUi()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func forgotPassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiForgotPassword) -> Void) {
        vc.blockUi()
        Service.post(url: Router.ForgotPassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiForgotPassword.self, from: response)
                if root.result != nil {
                    success(root)
                }
            } catch {
                print(error)
                
            }
            vc.unBlockUi()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func getProfile(_ vc: UIViewController, _ success: @escaping(_ responseData : ResProfile) -> Void) {
//        vc.showProgressBar()
        Service.post(url: Router.Profile.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiProfile.self, from: response)
                if let result = root.result {
                    success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func updatedProfile(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : ResUpdateProfile) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.UpdateProfile.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiUpdatedProfile.self, from: response)
                if root.status == "1" {
                    vc.hideProgressBar()
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
//                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func changePassword(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.UpdatedPassword.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                    vc.hideProgressBar()
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getcart(_ vc: UIViewController, _ success: @escaping(_ responseData : [Rescart]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.cart.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Apicart.self, from: response)
                if let result = root.result {
                      success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getAdvertisment(_ vc: UIViewController, _ success: @escaping(_ responseData : [ResAdvertisement]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getAdvertisement.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAdvertisement.self, from: response)
                if let result = root.result {
                      success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getPdfDocument(_ vc: UIViewController, _ success: @escaping(_ responseData : ResDocument) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getPdfDocument.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiPdfDocument.self, from: response)
                if let result = root.result {
                      success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getManagingAgent(_ vc: UIViewController, _ success: @escaping(_ responseData : ResManagingAgent) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getManagingAgent.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiManagingAgent.self, from: response)
                if let result = root.result {
                      success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getTermCondition(_ vc: UIViewController, _ success: @escaping(_ responseData : ResTermCondition) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getTermCondition.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiTermCondition.self, from: response)
                if let result = root.result {
                      success(result)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addCleaningService(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResCleaningService) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.addCleaningService.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiCleaningService.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                }
                vc.hideProgressBar()
            } catch {
                print(error)
                vc.hideProgressBar()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addCommonBooking(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResBooking) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.addCommonbooking.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBooking.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                }
                vc.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addApartmentReport(_ vc: UIViewController, _ params: [String: String], images: [String : Array<Any>?]?, videos: [String : Array<Any>?]?, _ success: @escaping(_ responseData : ResApartmentReport) -> Void) {
        vc.showProgressBar()
        Service.postWithMedia(url: Router.addApartmentReport.url(), params: params, imageParam: images, videoParam: videos, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiApartmentReport.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    //                    vc.alert(alertmessage: root.message ?? R.string.localizable.somethingWentWrong())
                }
            } catch {
                print(error)
                vc.hideProgressBar()
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func stripePayment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        Service.callPostService(apiUrl: Router.StripePayment.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    
    func addMeterReading(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResReading) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.addMeterReading.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiMeter.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
                vc.hideProgressBar()
            } catch {
                print(error)
                vc.hideProgressBar()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func getvideos(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : [ResVideos]) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.getvideos.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiVideos.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
                vc.hideProgressBar()
            } catch {
                print(error)
                vc.hideProgressBar()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func deleteAccount(_ vc: UIViewController, _ success: @escaping(_ responseData : ApiBasic) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.deleteAccount.url(), params: self.paramGetUserId(), method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiBasic.self, from: response)
                if root.result != nil {
                    success(root)
                    vc.hideProgressBar()
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func addPayment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : ResAddPayment) -> Void) {
        vc.showProgressBar()
        Service.post(url: Router.addPayment.url(), params: params, method: .get, vc: vc, successBlock: { (response) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(ApiAddPayment.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vc.hideProgressBar()
                    }
                } else {
                    vc.alert(alertmessage: root.message ?? "Something Went Wrong!")
                    vc.hideProgressBar()
                }
                vc.hideProgressBar()
            } catch {
                print(error)
                vc.hideProgressBar()
            }
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
}

