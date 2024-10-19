//
//  LoginVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblagent: UILabel!
    @IBOutlet weak var lblaccount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func BtnLogin(_ sender: Any) {
        if self.txtEmail.hasText && self.txtPassword.hasText {
            self.login()
        }else{
            self.alert(alertmessage: "Please Enter the Required Details!")
        }
    }
    
    @IBAction func BtnForget(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func BtnArrow(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func login()
    {
        dump(self.paramDetails())
        Api.shared.login(self, self.paramDetails()) { responseData in
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
            k.userDefault.set("\(responseData.first_name ?? "") \(responseData.last_name ?? "")", forKey: k.session.userName)
            k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(responseData.type ?? "", forKey: k.session.userType)
            Switcher.checkLogin()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict:[String: AnyObject]         = [:]
        dict["email"]                  = self.txtEmail.text! as AnyObject
        dict["password"]               = self.txtPassword.text! as AnyObject
        dict["register_id"]            = k.emptyString as AnyObject
        dict["lat"]                    = k.emptyString as AnyObject
        dict["lon"]                    = k.emptyString  as AnyObject
        return dict
    }
}
