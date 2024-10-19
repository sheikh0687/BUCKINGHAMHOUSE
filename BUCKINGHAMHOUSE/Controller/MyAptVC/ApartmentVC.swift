//
//  ApartmentVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit

class ApartmentVC: UIViewController {
  
    @IBOutlet weak var lblName: UILabel!
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pdfDocument()
    }

    @IBAction func Btnarrow(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func pdfDocument()
    {
        Api.shared.getPdfDocument(self) { responseData in
            let obj = responseData
            self.url = obj.welcome_document ?? ""
            self.lblName.text = obj.welcome_document_name ?? ""
        }
    }
    
    @IBAction func btnPdf(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentVC") as! DocumentVC
        vc.strUrl = self.url
        print(vc.strUrl)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnDownload(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DownloadPdfVC") as! DownloadPdfVC
        vc.strUrl = self.url
        print(vc.strUrl)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
