//
//  PDFVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 02/08/23.
//

import UIKit

class PDFVC: UIViewController {
    
    @IBOutlet weak var collectionitem: UICollectionView!
    
    let identifier = "PdfCollectionCell"
    var url1 = ""
    var url2 = ""
    
    var arrvideo: [ResVideos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.collectionitem.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.navigationController?.navigationBar.isHidden = true
        collectionitem.dataSource = self
        collectionitem.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pdf()
    }
    
    func pdf()
    {
        Api.shared.getvideos(self, self.paramDetails()) { responseData in
            if responseData.count > 0
            {
                self.arrvideo = responseData
            }
            else
            {
                self.arrvideo = []
            }
            self.collectionitem.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        dict["type"]                   = "PDF" as AnyObject
        return dict
    }
}

extension PDFVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrvideo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionitem.dequeueReusableCell(withReuseIdentifier: "PdfCollectionCell", for: indexPath) as! PdfCollectionCell
        cell.lblTitle.text = self.arrvideo[indexPath.row].title ?? ""
        return cell
    }
}

extension PDFVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: (collectionView.frame.size.width/2), height: 180)
    }
}

extension PDFVC: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DocumentVC") as! DocumentVC
        vc.strUrl = self.arrvideo[indexPath.row].document_file ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

