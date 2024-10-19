//
//  AboutUsVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 04/10/23.
//

import UIKit

class AboutUsVC: UIViewController {

    @IBOutlet weak var lblAboutUs: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutUs()
    }
    
    func aboutUs()
    {
        Api.shared.getTermCondition(self) { responseData in
            let obj = responseData
            let html = obj.about_us ?? ""
            if let attributedStr = html.htmlToAttributedString
            {
                self.lblAboutUs.attributedText = attributedStr
            }
        }
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
