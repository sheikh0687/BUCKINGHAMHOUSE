//
//  PrivacyVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 02/08/23.
//

import UIKit

class PrivacyVC: UIViewController {
    
    @IBOutlet weak var lblPrivacy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        privacy()
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func privacy()
    {
        Api.shared.getTermCondition(self) { responseData in
            let obj = responseData
            let html = obj.privacy ?? ""
            if let attributedStr = html.htmlToAttributedString
            {
                self.lblPrivacy.attributedText = attributedStr
            }
        }
    }
}
