//
//  navigationExtension.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 03/08/23.
//

import UIKit

extension UIViewController {
    
    func hexStringToUIColor (hex:String) -> UIColor {
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
    
    func blockUi() {
        
        MBProgressHUD.hide(for: self.view, animated: true)
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        if spinnerActivity.isUserInteractionEnabled {
            spinnerActivity.bezelView.isHidden = true
            spinnerActivity.bezelView.color = .clear
            spinnerActivity.isUserInteractionEnabled = true;
        }
    }
    
    func showProgressBar() {
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        spinnerActivity.label.text = "Loading";
        spinnerActivity.detailsLabel.text = "Please Wait";
        spinnerActivity.isUserInteractionEnabled = true;
    }
    
    func hideProgressBar() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func unBlockUi() {
        
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func alert(alertmessage: String) {
        
        let alert = UIAlertController(title: "", message: alertmessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }
                                     )
        )
        self.present(alert as UIViewController, animated: true, completion: nil)
    }
    
    func getStringSize(string: String, fontSize: CGFloat) -> CGSize {
        let size: CGSize = string.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        return size
    }
    
    func showToast(message: String) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(toast, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            toast.dismiss(animated: true, completion: nil)
        }
    }
}
