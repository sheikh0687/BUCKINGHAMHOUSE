//
//  CleanserviceVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 02/08/23.
//

import UIKit

class CleanserviceVC: UIViewController {
    
    @IBOutlet weak var btnDateOt: UIButton!
    @IBOutlet weak var btnTime1: UIButton!
    @IBOutlet weak var btnTime2: UIButton!
    @IBOutlet weak var btnTime3: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    
    var cloCalender: (() -> Void)?
    var timeSlot = ""
    var selectedDate = ""
    var amount = ""
    var arrSelectedTime: [String] = []
    var arrSelectedAmount: [String] = []
    
    var isSelected = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
//    func handleButtonSelection(button: UIButton, timeSlot: String) {
//        if isSelected {
//            if button.isEnabled {
//                button.layer.borderColor = UIColor.orange.cgColor
//                button.layer.borderWidth = 3
//                arrSelectedTime.append(timeSlot)
//                isSelected = false
//            }
//        } else {
//            arrSelectedTime.remove(timeSlot)
//            button.layer.borderWidth = 0
//            isSelected = true
//        }
//    }
    
    @IBAction func btndate(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.cloOk = { getDate in
            self.lblDate.text = getDate
            self.selectedDate = getDate
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func handleButtonSelection(button: UIButton, timeSlot: String) {
        if arrSelectedTime.contains(timeSlot) {
            // Deselect the button
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.borderWidth = 1
            if let index = arrSelectedTime.firstIndex(of: timeSlot) {
                arrSelectedTime.remove(at: index)
            }
        } else {
            // Check if selecting this time slot won't exceed the maximum allowed selections
            if arrSelectedTime.count < 3 {
                // Select the button
                button.layer.borderColor = UIColor.orange.cgColor
                button.layer.borderWidth = 3
                arrSelectedTime.append(timeSlot)
            }
        }
    }
    
    @IBAction func btnTime1(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "09.30 am - 11.30 am")
    }
    
    @IBAction func btnTime2(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "11.30 am - 01.30 pm")
    }
    
    @IBAction func btnTime3(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "01.30 pm - 03.30 pm")
    }
    
    @IBAction func Btnnext(_ sender: Any) {
        self.timeSlot = self.arrSelectedTime.joined(separator: ",")
        print(self.timeSlot)
        if self.timeSlot == "09.30 am - 11.30 am,11.30 am - 01.30 pm" || self.timeSlot == "09.30 am - 11.30 am,01.30 pm - 03.30 pm" || self.timeSlot == "11.30 am - 01.30 pm,09.30 am - 11.30 am" || self.timeSlot == "11.30 am - 01.30 pm,01.30 pm - 03.30 pm" || self.timeSlot == "01.30 pm - 03.30 pm,11.30 am - 01.30 pm" || self.timeSlot == "01.30 pm - 03.30 pm,09.30 am - 11.30 am"{
            self.amount = "100"
        }else if self.timeSlot == "09.30 am - 11.30 am" || self.timeSlot == "11.30 am - 01.30 pm" || self.timeSlot == "01.30 pm - 03.30 pm"{
            self.amount = "50"
        }else{
            self.amount = "150"
        }
        if self.selectedDate == ""{
            self.alert(alertmessage: "Please select the date!")
        }else if timeSlot == "" {
            self.alert(alertmessage: "Please select the time slot!")
        }else{
            self.cleanservice()
        }
    }
    
    func cleanservice()
    {
        Api.shared.addCleaningService(self, self.paramDetails()) { responseData in
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
            vc.requestId = responseData.id ?? ""
            vc.amount = self.amount
            print(vc.amount)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict:[String: AnyObject]   = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["amount"]                 = self.amount as AnyObject
        dict["time_slot"]              = self.timeSlot as AnyObject
        dict["booking_date"]           = self.selectedDate as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}





