//
//  TermsCondtionVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 06/10/23.
//

import UIKit

class TermsCondtionVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsCondition()
    }
    
    func termsCondition()
    {
        Api.shared.getTermCondition(self) { responseData in
            let obj = responseData
            let html = obj.term ?? ""
            if let attributedStr = html.htmlToAttributedString
            {
                self.lblName.attributedText = attributedStr
            }
        }
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
