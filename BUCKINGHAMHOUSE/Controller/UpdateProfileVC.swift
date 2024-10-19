//
//  UpdateProfileVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 02/08/23.
//

import UIKit
import CountryPickerView

class UpdateProfileVC: UIViewController {
    
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtMobilenumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var profileImg: UIButton!
    
    let cpvInternal = CountryPickerView()
    weak var cpvTextField: CountryPickerView!
    
    var phoneKey:String?
    var phoneNumber: String = ""
    var countryCode = ""
    var countryCodeWithoutPlus = ""
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCountryView()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profile()
    }
    
    func configureCountryView() {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        txtMobilenumber.leftView = cp
        txtMobilenumber.leftViewMode = .always
        self.cpvTextField = cp
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        cp.countryDetailsLabel.font = UIFont(name: "Cairo-Bold", size: 14.0)
        self.phoneKey = cp.selectedCountry.phoneCode
    }
    
    func profile()
    {
        Api.shared.getProfile(self) { responseData in
            let obj = responseData
            self.txtFirstname.text = obj.first_name ?? ""
            self.txtLastname.text = obj.last_name ?? ""
            self.txtEmail.text = obj.email ?? ""
            self.txtMobilenumber.text = obj.mobile ?? ""
            if obj.image != Router.BASE_IMAGE_URL
            {
                Utility.downloadImageBySDWebImage(obj.image ?? "") { image, error in
                    if image != nil {
                        self.profileImg.setImage(image, for: .normal)
                    }else{
                        self.profileImg.setImage(UIImage(named: "profile2"), for: .normal)
                    }
                }
            }
        }
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
    
    @IBAction func BtnArrow(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Btnsave(_ sender: Any) {
        updateProfile()
    }
    
    func updateProfile()
    {
        if self.txtEmail.hasText && self.txtFirstname.hasText && self.txtFirstname.hasText && txtMobilenumber.hasText{
            Api.shared.updatedProfile(self, self.profileParam(), images: self.profileImage(), videos: [:]) { responseData in
                Utility.showAlertWithAction(withTitle: k.appName, message: "Profile updated successfully!", delegate: nil, parentViewController: self) { boool in
                    self.profile()
                }
            }
        }else{
            self.alert(alertmessage: "Please Enter the Required Details!")
        }
    }
    
    func profileParam() -> [String : String]
    {
        let paramDetails =
        [
            "user_id": k.userDefault.string(forKey: k.session.userId)!,
            "first_name": self.txtFirstname.text!,
            "last_name": self.txtLastname.text!,
            "mobile": self.txtMobilenumber.text!,
            "about_us": k.emptyString,
            "address": k.emptyString,
            "lat": k.emptyString,
            "lon": k.emptyString
        ]
        return paramDetails
    }
    
    func profileImage() -> [String : UIImage]
    {
        var imageDict: [String : UIImage] = [:]
        imageDict["image"] = image
        print(imageDict)
        return imageDict
    }
}

extension UpdateProfileVC: CountryPickerViewDelegate {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
        self.countryCode = country.phoneCode
        self.countryCodeWithoutPlus = countryCode.replacingOccurrences(of: "+", with: "")
    }
}

extension UpdateProfileVC: CountryPickerViewDataSource {
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["GB"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}
