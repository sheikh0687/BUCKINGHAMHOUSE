//
//  PaymentVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 21/09/23.
//

import UIKit
import InputMask
import Stripe
import SwiftyJSON
import PassKit

class PaymentVC: UIViewController {
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var txtCardHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet var listnerCardNum: MaskedTextFieldDelegate!
    @IBOutlet var listerExpiryDate: MaskedTextFieldDelegate!
    
    var amount = ""
    //    var userRequestId = ""
    //    var productOwnerId = ""
    var requestId = ""
    var statusCheck = true
    
    let ApplePaySwagMerchantID = "merchant.BUCKINGHAMHOUSE"
//    let paymentNetworks = [PKPaymentNetwork.amex, .discover, .masterCard, .visa]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblAmount.text = "£ \(self.amount)"
        self.configureListener()
    }
    
    func configureListener()
    {
        listnerCardNum.affinityCalculationStrategy = .prefix
        listnerCardNum.affineFormats = ["[0000] [0000] [0000] [0000]"]
        
        listerExpiryDate.affinityCalculationStrategy = .prefix
        listerExpiryDate.affineFormats = ["[00]/[00]"]
    }
    
    func cardValidation()
    {
        let cardParams = STPCardParams()
        
        // Split the expiration date to extract Month & Year
        if self.txtCardHolderName.text?.isEmpty == false && self.txtSecurityCode.text?.isEmpty == false && self.txtExpiryDate.text?.isEmpty == false && self.txtExpiryDate.text?.isEmpty == false {
            let expirationDate = self.txtExpiryDate.text?.components(separatedBy: "/")
            let expMonth = UInt((expirationDate?[0])!)
            let expYear = UInt((expirationDate?[1])!)
            
            // Send the card info to Strip to get the token
            cardParams.number = self.txtCardNumber.text
            cardParams.cvc = self.txtSecurityCode.text
            cardParams.expMonth = expMonth!
            cardParams.expYear = expYear!
            
            //            let cardBrand = STPCardValidator.brand(forNumber: self.txtCardNumber.text!)
            //            let cardImage = STPImageLibrary.brandImage(for: cardBrand)
            //            self.imgWallet.image = cardImage
        }
        
        let cardState = STPCardValidator.validationState(forCard: cardParams)
        switch cardState {
        case .valid:
            self.generateToken(cardParams)
        case .invalid:
            self.alert(alertmessage: "Card Is Invalid!")
        case .incomplete:
            self.alert(alertmessage: "Card Is Incomplete!")
        default:
            print("default")
        }
    }
    
    func generateToken(_ cardParams: STPCardParams)
    {
        STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            self.showProgressBar()
            guard let token = token, error == nil else {
                Utility.showAlertWithAction(withTitle: k.appName, message: "Something Went Wrong!", delegate: nil, parentViewController: self, completionHandler: { (boool) in
                    self.hideProgressBar()
                })
                return
            }
            self.hideProgressBar()
            print(token.tokenId)
            self.addPayment(token.tokenId)
        }
    }
    
    func addPayment(_ token: String)
    {
        Api.shared.addPayment(self, self.addPaymentParam(token)) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Payment successfully done!", delegate: nil, parentViewController: self) { boool in
                self.dismiss(animated: true) {
                    Switcher.checkLogin()
                }
            }
        }
    }
    
    func addPaymentParam(_ getToken: String) -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject
        dict["request_id"]             = self.requestId as AnyObject
        dict["total_amount"]           = self.amount as AnyObject
        dict["token"]                  = getToken as AnyObject
        dict["payment_method"]         = "Card" as AnyObject
        dict["currency"]               = "GBP" as AnyObject
        print(dict)
        return dict
    }
    
    @IBAction func btnPay(_ sender: UIButton)
    {
        cardValidation()
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnApplePay(_ sender: UIButton)
    {
        payByApplePay()
    }
    
    func payByApplePay() {
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = ApplePaySwagMerchantID
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.countryCode = "GB"
        request.currencyCode = "GBP"
        request.supportedNetworks = [.amex, .visa, .masterCard, .discover]
        
        let paymentItemsss = PKPaymentSummaryItem.init(label: "With Apple", amount: NSDecimalNumber(value: Double(self.amount) ?? 0.0))
        request.paymentSummaryItems = [paymentItemsss]
        
        guard let presentController = PKPaymentAuthorizationViewController(paymentRequest: request) else {
            self.alert(alertmessage: "Unable to present Apple Pay authorization.")
            return
        }
        presentController.delegate = self
        self.present(presentController, animated: true, completion: nil)
    }
}

extension PaymentVC: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let payment = payment.token.transactionIdentifier
        addPayment(payment)
    }
}
