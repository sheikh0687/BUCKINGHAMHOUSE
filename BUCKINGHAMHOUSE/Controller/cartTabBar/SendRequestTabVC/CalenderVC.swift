//
//  CalenderVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 12/09/23.
//

import UIKit

class CalenderVC: UIViewController {
    
    
    @IBOutlet weak var date: UIDatePicker!
    
    var cloCancel: (() -> Void)?
    var cloOk: ((_ currentdate: String) -> Void)?
    @objc var selectedDate:String = ""
    
    var dateformate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.datePickerMode = .date
      
    
        if let oneWeeksFromNow = Calendar.current.date(byAdding: .day, value: 7, to: Date()) {
            date.date = oneWeeksFromNow
            self.date.minimumDate = oneWeeksFromNow
        }
        
        // Optionally, you can add a target to respond to date changes
        date.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
         // Handle date changes here if needed
         let selectedDate = sender.date
         print("Selected Date: \(selectedDate)")
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
