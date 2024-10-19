//
//  AdvertisementDatailVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 29/09/23.
//

import UIKit

class AdvertisementDatailVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var code = ""
    var url = ""
    var varDescription = ""
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblCode.text = self.code
        self.lblUrl.text = self.url
        self.lblDescription.text = self.varDescription
        self.img.image = self.image
        
        lblCode.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(codeCopied(_:)))
        lblCode.addGestureRecognizer(tapGesture)
    }

    @objc func codeCopied(_ sender: UITapGestureRecognizer)
    {
        if let textToCopy = lblCode.text {
            // Copy the label's text to the clipboard
            UIPasteboard.general.string = textToCopy
            
            // Display a brief message to indicate the text has been copied (optional)
            showToast(message: "Copied to clipboard")
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUrl(_ sender: UIButton)
    {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "LinkVC") as! LinkVC
        vc.strUrl = self.url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
