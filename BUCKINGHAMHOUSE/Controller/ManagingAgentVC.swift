//
//  ManagingAgentVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 29/09/23.
//

import UIKit
import MessageUI

class ManagingAgentVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var adminPhone = ""
    var adminEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmail.isUserInteractionEnabled = true
        lblMobile.isUserInteractionEnabled = true
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(labelTapped1(_:)))
        lblEmail.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(labelTapped2(_:)))
        lblMobile.addGestureRecognizer(tapGesture2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        managingAgent()
    }
    
    @objc func labelTapped1(_ sender: UITapGestureRecognizer) {
        openMailbox()
    }
    
    func openMailbox() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients([self.adminEmail]) // Set the recipient's email address (optional)
            mailComposer.setSubject("Your Email Subject")
            mailComposer.setMessageBody("Your email message body", isHTML: false)
            
            // Present the mail composer view controller
            self.present(mailComposer, animated: true, completion: nil)
        } else {
            // Device is not configured for sending emails
            // You can display an alert or take another action
            print("Email is not available on this device.")
        }
    }
    
    // Implement the MFMailComposeViewControllerDelegate method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func labelTapped2(_ sender: UITapGestureRecognizer) {
        Utility.callNumber(phoneNumber: self.adminPhone)
    }
    
    func managingAgent()
    {
        Api.shared.getManagingAgent(self) { responseData in
            let obj = responseData
            self.lblName.text = obj.agent_name ?? ""
            self.lblEmail.text = obj.agent_email ?? ""
            self.lblMobile.text = obj.agent_mobile ?? ""
            self.adminPhone = obj.agent_mobile ?? ""
            self.adminEmail = obj.agent_email ?? ""
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
