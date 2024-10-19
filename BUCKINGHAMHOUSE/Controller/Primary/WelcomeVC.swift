//
//  WelcomeVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 01/08/23.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var Welcomecollection: UICollectionView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    
    var currentIndex = 0
    let identifier = "WelcomeCell"
    
    var arrImageList =
    [
        UIImage(named: "Slide_1"),
        UIImage(named: "Slide_2"),
        UIImage(named: "Slide_3")
    ]
    
    var arrlblList =
    [
        "Welcome to Buckingham House",
        "Available Important Information or Videos",
        "You Also Share Your Home Related Issues"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Welcomecollection.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func BtnNext(_ sender: Any) {
        if self.currentIndex < (self.arrImageList.count - 1) {
            self.currentIndex = self.currentIndex + 1
            self.pagecontrol.currentPage = self.currentIndex
            print(pagecontrol.currentPage)
            print(currentIndex)
            print(self.arrImageList.count)
            DispatchQueue.main.async {
                self.Welcomecollection.isPagingEnabled = false
                self.Welcomecollection.scrollToItem(at: IndexPath(item: self.currentIndex, section: 0), at: .centeredHorizontally, animated: true
                )
                self.Welcomecollection.isPagingEnabled = true
            }
        }else if pagecontrol.currentPage == 3 {
            self.btnNext.setTitle("Start", for: .normal)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension WelcomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCell", for: indexPath) as! WelcomeCell
        cell.imgCell.image = self.arrImageList[indexPath.row]
        cell.lblWelcome.text = self.arrlblList[indexPath.row]
        return cell
    }
}

extension WelcomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}

extension WelcomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pagecontrol.currentPage = indexPath.row
        self.currentIndex = indexPath.row
    }
}



