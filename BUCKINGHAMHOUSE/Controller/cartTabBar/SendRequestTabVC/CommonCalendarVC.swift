
//
//  CommonCalendarVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 22/09/23.
//

import UIKit

class CommonCalendarVC: UIViewController {
    
    @IBOutlet weak var date: UIDatePicker!

    var cloCancel: (() -> Void)?
    var cloOk: ((_ currentdate: String) -> Void)?
    @objc var selectedDate:String = ""
    
    var dateformate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        date.datePickerMode = .date
//        
//        // Calculate the date two weeks from the current date
//        if let twoWeeksFromNow = Calendar.current.date(byAdding: .day, value: 14, to: Date()) {
//            date.date = twoWeeksFromNow
//        }
//        
//        // Optionally, you can add a target to respond to date changes
//        date.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
             date.minimumDate = Date()
           }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
           // Handle the selected date here
           let selectedDate = sender.date
           print("Selected date: \(selectedDate)")
       }

    @IBAction func btnOk(_ sender: UIButton) {
        if self.dateformate == ""{
            self.alert(alertmessage: "Please select the date!")
        }else{
            self.cloOk?(self.dateformate)
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func Datepicker(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        self.dateformate = dateformatter.string(from: selectedDate)
        print(dateformate)
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
