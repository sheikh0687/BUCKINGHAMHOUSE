//
//  SplashVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit

class SplashVC: UIViewController {

    
    @IBOutlet weak var splashimg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(moveToNext), with: self, afterDelay: 3)
        
    }
        @objc func moveToNext() {
            
          let VC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
         self.navigationController?.pushViewController(VC, animated: true)
        }
    
}
