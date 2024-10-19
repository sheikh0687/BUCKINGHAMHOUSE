//
//  SendRequestVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit


class SendRequestVC: UIViewController {

    
    @IBOutlet weak var lblNew: UILabel!
    @IBOutlet weak var imglogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.isHidden = true
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    
//    func getBookingClean()
//    {
//        dump(self.paramDetails())
//        Api.shared.getSevice(self, self.paramDetails()) { responseData in
//            k.userDefault.set(true, forKey: k.session.status)
//     //     k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
//            k.userDefault.set("\(responseData.user_id ?? "") \(responseData.amount ?? "")", forKey: k.session.userName)
//            k.userDefault.set(responseData.time_slot ?? "", forKey: k.session.userEmail)
//            k.userDefault.set(responseData.booking_date ?? "", forKey: k.session.userType)
//            Switcher.checkLogin()
//        }
//    }
    
    func paramDetails() -> [String : AnyObject]
    {
       var dict:[String: AnyObject]         = [:]
        dict["user_id"]                     = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["amount"]                      = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["time_slot"]                   = k.emptyString as AnyObject
        dict["booking_date"]                = k.emptyString as AnyObject
           
        return dict
    }
    
    @IBAction func BtnReport(_ sender: Any) {
        
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "NewEnquiryVC") as! NewEnquiryVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func Btncommunal(_ sender: Any) {
        
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "ReportFaultVC") as! ReportFaultVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func Btnmeter(_ sender: Any) {
        
         let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MeterRequestVC") as! MeterRequestVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    @IBAction func BtnBook(_ sender: Any) {
        
        
        
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "CleanserviceVC") as! CleanserviceVC
       self.navigationController?.pushViewController(vc, animated: true)

   
    }
    
    
    @IBAction func BtnRoom(_ sender: Any) {
    
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "BookingRoomVC") as! BookingRoomVC
       self.navigationController?.pushViewController(vc, animated: true)

        
  
    }
    
    
    
}
