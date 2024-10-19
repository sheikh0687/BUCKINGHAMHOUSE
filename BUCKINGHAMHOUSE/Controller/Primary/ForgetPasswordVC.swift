//
//  ForgetPasswordVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit

class ForgetPasswordVC: UIViewController {
    
    @IBOutlet weak var lblForgetPassword: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BtnSend(_ sender: Any) {
        if self.txtEmail.hasText{
            self.forgotPassword()
        }else{
            self.alert(alertmessage: "Please Enter the Email!")
        }
    }
    
    func forgotPassword() {
        Api.shared.forgotPassword(self, self.paramForgetPassword()) { (response) in
            if response.status == "1" {
                Utility.showAlertWithAction(withTitle: k.appName, message: "New password has sent to your email!", delegate: nil, parentViewController: self) { (bool) in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                Utility.showAlertMessage(withTitle: k.appName, message: "Email does not exist!", delegate: nil, parentViewController: self)
            }
        }
    }
    
    func paramForgetPassword() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["email"]                  = self.txtEmail.text! as AnyObject
        return dict
    }
}
