//
//  DeleteAccountVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 08/08/23.
//

import UIKit

class DeleteAccountVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func BtnOk(_ sender: Any) {
        deleteAccount()
    }
    
    func deleteAccount()
    {
        Api.shared.deleteAccount(self) { responseData in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            Switcher.checkLogin()
        }
    }
    
    @IBAction func BtnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
