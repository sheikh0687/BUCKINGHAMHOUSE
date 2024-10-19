//
//  VideosVC.swift
//  BUCKINGHAMHOUSE
//
//  Created by Tarun Sharma on 02/08/23.
//

import UIKit
import AVKit
import AVFoundation

class VideosVC: UIViewController {
    
    @IBOutlet weak var videotable: UITableView!
    var arrvideo : [ResVideos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let nib = UINib(nibName: "VideoTableCell", bundle: nil)
        videotable.register(nib, forCellReuseIdentifier: "VideoTableCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videosS()
    }
    
    func videosS()
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
            self.videotable.reloadData()
        }
    }
    
    func paramDetails() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"]                = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        dict["type"]                   = "VIDEO" as AnyObject
        return dict
    }
}

extension VideosVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrvideo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableCell", for: indexPath) as! VideoTableCell
        let obj = arrvideo[indexPath.row]
        
        cell.lbltest.text = obj.title ?? ""
        if Router.BASE_IMAGE_URL != obj.video_thum ?? ""
        {
            Utility.setImageWithSDWebImage(obj.video_thum ?? "", cell.imgVideo)
        }
        return cell
    }
}

extension VideosVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoPlayerVC") as! VideoPlayerVC
        vc.strVideoUrl = self.arrvideo[indexPath.row].document_file ?? ""
        print(vc.strVideoUrl)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

