//
//  MyAptVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit

class MyAptVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    

    @IBAction func BtnDocuments(_ sender: Any) {
   
        let vc =  self.storyboard?.instantiateViewController(identifier: "ApartmentVC") as! ApartmentVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func BtnVideo(_ sender: Any) {
        
        let vc =  self.storyboard?.instantiateViewController(identifier: "ManualVC") as! ManualVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func BtnSafety(_ sender: Any) {
        
        let vc =  self.storyboard?.instantiateViewController(identifier: "SafetyVC") as! SafetyVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
