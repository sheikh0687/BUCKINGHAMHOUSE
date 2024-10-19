//
//  BookingRoomVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 02/08/23.
//

import UIKit

class BookingRoomVC: UIViewController {
   
    @IBOutlet weak var btnDateOt: UIButton!
    @IBOutlet weak var btnTime1: UIButton!
    @IBOutlet weak var btnTime2: UIButton!
    @IBOutlet weak var btnTime3: UIButton!
    @IBOutlet weak var btnTime4: UIButton!
    @IBOutlet weak var btnTime5: UIButton!
    @IBOutlet weak var btnTime6: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    
    var cloCalender: (() -> Void)?
    var isSelected = true
    
    var timeSlot = ""
    var selectedDate = ""
    var arrSelectedTime: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BtnDate(_ sender: UIButton) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "CommonCalendarVC") as! CommonCalendarVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.cloOk = { getDate in
            self.lblTime.text = getDate
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
            if arrSelectedTime.count < 6 {
                // Select the button
                button.layer.borderColor = UIColor.orange.cgColor
                button.layer.borderWidth = 3
                arrSelectedTime.append(timeSlot)
            }
        }
    }

    
    @IBAction func btnTime1(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "09.00 am - 01.00 pm")
    }
    
    @IBAction func btnTime2(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "01.00 pm - 05.00 pm")
    }
    
    @IBAction func btnTime3(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "05.00 pm - 09.00 pm")
    }
    
    @IBAction func btnTime4(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "09.00 pm - 01.00 am")
    }
    
    @IBAction func btnTime5(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "01.00 am - 05.00 am")
    }
    
    @IBAction func btnTime6(_ sender: UIButton) {
        handleButtonSelection(button: sender, timeSlot: "05.00 am - 09.00 am")
    }
    
    
    @IBAction func BtnSendrequest(_ sender: Any) {
        self.timeSlot = self.arrSelectedTime.joined(separator: ",")
        print(timeSlot)
        if self.selectedDate == ""{
            self.alert(alertmessage: "Please select the date!")
        }else if timeSlot == "" {
            self.alert(alertmessage: "Please select the time slot!")
        }else{
            self.updateBooking()
        }
    }
    
    func updateBooking()
    {
        Api.shared.addCommonBooking(self, self.paramDetails()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Common Room - booking sent successfully", delegate: nil, parentViewController: self) { Boool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict:[String: AnyObject]   = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["time_slot"]              = self.timeSlot as AnyObject
        dict["booking_date"]           = self.selectedDate as AnyObject
        print(dict)
        return dict
    }
}


