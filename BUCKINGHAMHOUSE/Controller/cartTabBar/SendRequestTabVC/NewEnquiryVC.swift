//
//  NewEnquiryVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit
import Gallery

class NewEnquiryVC: UIViewController {
    
    
    @IBOutlet weak var lblAddimage: UILabel!
    @IBOutlet weak var imgcollection: UICollectionView!
    @IBOutlet weak var imglogo: UIImageView!
    @IBOutlet weak var lblReportf: UILabel!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtView: UITextView!
    
    
//    var identifier = "PhotoCell"
    var arrimage : [[String : AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.imgcollection.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.navigationController?.navigationBar.isHidden = true
        self.txtView.addHint("Let us know about any issues in your apartment")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func Btnback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCamera(_ sender: Any) {
        Config.Camera.recordLocation = true
        Config.Camera.imageLimit = 3
        Config.tabsToShow = [.imageTab, .cameraTab]
        let gallery = GalleryController()
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    @IBAction func btnSendRequest(_ sender: UIButton) {
        if self.txtTitle.text == ""{
            self.alert(alertmessage: "Please enter the title!")
        }else if self.txtView.text == ""{
            self.alert(alertmessage: "Please enter the description")
        }else if self.arrimage.count == 0{
            self.alert(alertmessage: "Please select the image")
        }else{
            report()
        }
    }
    
    func report()
    {
        Api.shared.addApartmentReport(self, self.paramDetails(), images: self.paramImages(), videos: [:]) { responseData in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Report a fault - fault submitted successfully", delegate: nil, parentViewController: self) { Boool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func paramDetails() -> [String : String]
    {
        var dict: [String : String] = [:]
        dict["user_id"]             = k.userDefault.value(forKey: k.session.userId) as? String
        dict["title"]               = self.txtTitle.text
        dict["description"]         = self.txtView.text
        dict["timezone"]            = localTimeZoneIdentifier
        dict["type"]                = "apartment"
        print(dict)
        return dict
    }
 
    func paramImages() -> [String : Array<Any>]
    {
        var dict: [String : Array<Any>] = [:]
        var paramImage: [UIImage] = []
        if arrimage.count > 0{
            for val in arrimage{
                if let type = val["type"] as? String, type == "local"{
                    paramImage.append(val["image"] as! UIImage)
                }
            }
        }
        dict["fault_report_images[]"] = paramImage
        print(dict)
        return dict
    }
}

extension NewEnquiryVC: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        Image.resolve(images: images, completion: { [weak self] resolvedImages in
            print(resolvedImages.compactMap({ $0 }))
            for img in resolvedImages {
                var dict : [String:AnyObject] = [:]
                dict["image"] = img as AnyObject
                dict["type"] = "local" as AnyObject
                self?.arrimage.append(dict)
            }
            self!.imgcollection.reloadData()
        })
        self.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        print(video)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        print([Image].self)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController)
    {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewEnquiryVC: UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrimage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        
        if let img = arrimage[indexPath.row]["image"] as? UIImage {
            cell.btn_Image.setImage(img, for: .normal)
        }
        
        cell.btn_Image.tag = indexPath.row
        cell.btn_Image.addTarget(self, action: #selector(click_On_tab(button:)), for: .touchUpInside)
        
        cell.btn_cross.isHidden = false
        cell.btn_cross.tag = indexPath.row
        cell.btn_cross.addTarget(self, action: #selector(click_On_Cross(button:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func click_On_Cross(button:UIButton)  {
        print(button.tag)
        //        if self.objContract?.contractsImages?.count ?? 0 > button.tag {
        //            if let type =  self.arrImage[button.tag]["type"] as? String, type == "server" {
        //                self.deleteImage(self.arrImage[button.tag]["id"] as! String)
        //            }
        //        }
        arrimage.remove(at: button.tag)
        self.imgcollection.reloadData()
    }
    
    @objc func click_On_tab(button:UIButton)  {
        //        CameraHandler.shared.showActionSheet(vc: self)
        //        CameraHandler.shared.imagePickedBlock = { (image) in
        //            DispatchQueue.main.async {
        //                self.arr_Image[button.tag] = image
        //                self.collec_Photo.reloadData()
        //            }
        //        }
    }
}

extension NewEnquiryVC: UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: 100, height: 90)
    }
}
