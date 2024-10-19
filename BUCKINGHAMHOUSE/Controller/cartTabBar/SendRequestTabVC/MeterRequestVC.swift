//
//  MeterRequestVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit
import DropDown


class MeterRequestVC: UIViewController {
    
    @IBOutlet weak var MeterDropDown: UIButton!
    @IBOutlet weak var text: UITextView!
    
    let dropDown = DropDown()
    var arrSelectedList:[ResReading] = []
    
    var  ArrDlist =
    [
        "Electric Meter",
        "Water Meter "
    ]
    var SelectOption = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDropDown3()
        self.navigationController?.navigationBar.isHidden = true
        self.text.addHint("Request an electric or water meter reading for your apartment")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func btnmeter(_ sender: UIButton) {
        self.dropDown.show()
    }
    
    func configureDropDown3()
    {
        dropDown.anchorView = self.MeterDropDown
        dropDown.dataSource = self.ArrDlist
        dropDown.bottomOffset = CGPoint(x: -5, y: 45)
        dropDown.selectionAction = { [weak self] index, item in
            print("Selected item: \(item) at index: \(index)")
            self?.SelectOption = item
            self?.MeterDropDown.setTitle(item, for: .normal)
        }
    }
    
    @IBAction func btnSendrequest(_ sender: UIButton)
    {
        if self.SelectOption == ""
        {
            self.alert(alertmessage: "Please select the category!")
        }
        else if self.text.text == ""
        {
            self.alert(alertmessage: "Please enter the description")
        }
        else
        {
            addMeterReading()
        }
    }
    
    func addMeterReading()
    {
        Api.shared.addMeterReading(self, self.paramDetails()) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Meter reading request - sent successfully", delegate: nil, parentViewController: self) { boool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict:[String: AnyObject]   = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["timezone"]               = localTimeZoneIdentifier as AnyObject
        dict["description"]            = self.text.text as AnyObject
        dict["category_name"]          = self.SelectOption as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
