//
//  DocumentVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 21/09/23.
//

import UIKit
import WebKit
import PDFKit

class DocumentVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var viewOt: UIView!
    
    var strUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        let originalURLString = self.strUrl
        let updatedURLString = originalURLString.replacingOccurrences(of: "http://", with: "https://")
        // Load a URL in the web view
        if let url = URL(string: updatedURLString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
       
    }
}
