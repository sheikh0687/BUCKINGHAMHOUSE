//
//  cartVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 02/08/23.
//

import UIKit

class cartVC: UIViewController {
    
    @IBOutlet weak var offerCollectionView: UICollectionView!
    @IBOutlet weak var tableot: UITableView!
    
    let identifier = "homeTableviewcell"
    
    var arrcart: [Rescart] = []
    var arrAdvertisement: [ResAdvertisement] = []
    
    var cartId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableot.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.offerCollectionView.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "OffersCell")
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.savedcart()
        self.advertisement()
    }
    
    func savedcart()
    {
        Api.shared.getcart(self) { responseData in
            print(responseData)
            if responseData.count > 0
            {
                self.arrcart = responseData
            }else
            {
                self.arrcart = []
            }
            self.tableot.reloadData()
        }
    }
    
    func advertisement()
    {
        Api.shared.getAdvertisment(self) { responseData in
            if responseData.count > 0
            {
                self.arrAdvertisement = responseData
            }
            else
            {
                self.arrAdvertisement = []
            }
            self.offerCollectionView.reloadData()
        }
    }
}

extension cartVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrcart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableviewcell", for: indexPath) as! homeTableviewcell
        let obj = arrcart[indexPath.row]
        cell.lblpay.text = obj.title ?? ""
        cell.lblHello.text = obj.description ?? ""
        cell.lblDate.text = obj.date_time ?? ""
        return cell
    }
}

extension cartVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrAdvertisement.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCell", for: indexPath) as! OffersCell
        cell.obj = self.arrAdvertisement[indexPath.row]
        return cell
    }
}

extension cartVC: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension cartVC: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = Kstoryboard.instantiateViewController(withIdentifier: "AdvertisementDatailVC") as! AdvertisementDatailVC
        vc.code = self.arrAdvertisement[indexPath.row].title ?? ""
        vc.url = self.arrAdvertisement[indexPath.row].link ?? ""
        vc.varDescription = self.arrAdvertisement[indexPath.row].description ?? ""
        if let cell = collectionView.cellForItem(at: indexPath) as? OffersCell {
            if let selectedImage = cell.offerImg.image {
                vc.image = selectedImage
            } else {
                print("Selected cell's imageView.image is nil")
            }
        } else {
            print("Selected cell is nil")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
