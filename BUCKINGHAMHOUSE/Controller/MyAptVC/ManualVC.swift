//
//  ManualVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 03/08/23.
//

import UIKit


class ManualVC: UIViewController {
    
    @IBOutlet weak var videoContView: UIView!
    @IBOutlet weak var pdfContView: UIView!
    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var btnPdf: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.btnVideo.backgroundColor = .white
        self.btnVideo.setTitleColor(.black, for: .normal)
        self.btnPdf.backgroundColor = .white
        self.btnPdf.setTitleColor(.lightGray, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.videoContView.isHidden = false
        self.pdfContView.isHidden = true
    }
    
    @IBAction func Btnvideo(_ sender: Any) {
        self.videoContView.isHidden = false
        self.pdfContView.isHidden = true
        self.btnVideo.backgroundColor = .white
        self.btnVideo.setTitleColor(.black, for: .normal)
        self.btnPdf.backgroundColor = .white
        self.btnPdf.setTitleColor(.lightGray, for: .normal)
    }
    
    @IBAction func BtnPdf(_ sender: Any) {
        self.videoContView.isHidden = true
        self.pdfContView.isHidden = false
        self.btnVideo.backgroundColor = .white
        self.btnVideo.setTitleColor(.lightGray, for: .normal)
        self.btnPdf.backgroundColor = .white
        self.btnPdf.setTitleColor(.black, for: .normal)
    }
    
    func hexStringToUIColorApp (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

