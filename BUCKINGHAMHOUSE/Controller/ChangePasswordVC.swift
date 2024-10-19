//
//  ChangePasswordVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var txtcurrent: UITextField!
    @IBOutlet weak var txtnewPassword: UITextField!
    @IBOutlet weak var txtConfirmpassword: UITextField!
    @IBOutlet weak var imgB: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func BtnChangepass(_ sender: Any)
    {
        if self.txtcurrent.hasText && self.txtnewPassword.hasText && self.txtConfirmpassword.hasText {
            self.updatePassword()
        }else{
            self.alert(alertmessage: "Please Enter the Required Details!")
        }
    }
    
    func updatePassword()
    {
        Api.shared.changePassword(self, self.passwordParam()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "New Password Updated Successfully", delegate: nil, parentViewController: self) { bool in
                Switcher.checkLogin()
            }
        }
    }
    
    func passwordParam() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["password"]               = self.txtnewPassword.text! as AnyObject
        dict["old_password"]           = self.txtcurrent.text! as AnyObject
        return dict
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

