//
//  SettingVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit
import SDWebImage

class SettingVC: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profile()
    }
    
    func profile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.lblName.text = "\(obj.first_name ?? "") \(obj.last_name ?? "")"
            if obj.image != Router.BASE_IMAGE_URL
            {
                Utility.downloadImageBySDWebImage(obj.image ?? "") { image, error in
                    if image != nil {
                        self.imgProfile.image = image
                    }else{
                        self.imgProfile.image = UIImage(named: "profile2")
                    }
                }
            }
        }
    }
    
    @IBAction func BtnUpdatePro(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func BtnChangepassword(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func BtnPrivacy(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "PrivacyVC") as! PrivacyVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnAboutUs(_ sender: UIButton)
    {
        let vc = Kstoryboard.instantiateViewController(identifier: "AboutUsVC") as! AboutUsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTermsCondition(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "TermsCondtionVC") as! TermsCondtionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func BtnLogout(_ sender: Any) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        Switcher.checkLogin()
    }
    
    @IBAction func btnManagingAgent(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "ManagingAgentVC") as! ManagingAgentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    @IBAction func BtnDeleteacc(_ sender: Any) {
//        let vc = Kstoryboard.instantiateViewController(withIdentifier: "DeleteAccountVC") as! DeleteAccountVC
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true, completion: nil)
//    }
}






