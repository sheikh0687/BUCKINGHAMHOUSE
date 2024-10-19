//
//  DownloadPdfVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 22/09/23.
//

import UIKit
import WebKit

class DownloadPdfVC: UIViewController,WKNavigationDelegate {

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
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let snapshot = webView.snapshotViewHierarchy() else {
            return
        }
        
        // save photo
        UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil)
        self.exportToPDF(snapshot)
    }
    
    func exportToPDF(_ uiImage:UIImage) {
        let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("testing" + ".pdf")
        let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size:  uiImage.size))
        DispatchQueue.main.async {
            do {
                let imageBounds = CGRect(origin: .zero, size: uiImage.size)
                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                    context.beginPage()
                    uiImage.draw(in: imageBounds)
                  
                })
                print("wrote file to: \(outputFileURL.path)")
                let documentoPath = outputFileURL.path
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: documentoPath){
                                let documento = NSData(contentsOfFile: documentoPath)
                                let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                            }
                            else{
                                print("wrote file to: No Document \(outputFileURL.path)")
                            }
            }catch{
                print("Could not create PDF file: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
       
    }
}
