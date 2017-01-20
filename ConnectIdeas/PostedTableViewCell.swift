//
//  PostedTableViewCell.swift
//  ConnectIdeas
//
//  Created by shashank kannam on 1/18/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit
import Firebase

class PostedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var personImage: UIImageView!
    
    
    @IBOutlet weak var personName: UILabel!
    
    
    @IBOutlet weak var postedPersonImage: UIImageView!
    
    
    @IBOutlet weak var postedPersonTextView: UITextView!
    
    @IBOutlet weak var Likes: UILabel!
    
    
     var imgFeedCache:NSCache<NSString, UIImage> = NSCache()
    
     var imgPersonCache:NSCache<NSString, UIImage> = NSCache()
    
    
    @IBAction func likeButton(_ sender: UIButton) {
      
        
    }
    
    
    func configureCell(postData: PostData){
       personName.text = postData.personName
       postedPersonTextView.text = postData.idea
       Likes.text = postData.likes
       // print(postData.ideaImg)
       // print(postData.personImgURL)
        personImage.roundedImage()
        if let personImg = imgPersonCache.object(forKey: postData.personImgURL as NSString){
            print("Already in cache..........")
            personImage.image = personImg
        }else{
            downloadpersonImages(url: postData.personImgURL)
        }
        if let feedImg = imgFeedCache.object(forKey: postData.ideaImg as NSString){
            postedPersonImage.image = feedImg
            print("Already in cache..........")
        }else{
            downloadImages(url: postData.ideaImg)

        }
         }
    
    
    func downloadpersonImages(url: String){
        let urlA = NSString(string: url)
            let url = URL(string: url)!
            DispatchQueue.global().async {
                do
                {
                    let datax = try Data(contentsOf: url)
                    DispatchQueue.global().sync {
                        self.personImage.image = UIImage(data:datax)
                        self.imgPersonCache.setObject(self.personImage.image!, forKey: urlA)
                        //setValue(self.personImage.image, forKey: urlA)
                    }
               }
                catch{
                    
                }
        }
    }
    

    
  func downloadImages(url: String){
            let ref = DataService.dataserviceInstance.storagePosts.storage.reference(forURL: url)
            ref.data(withMaxSize: 2*1024*1024) { (data, error) in
                if error != nil{
                    print("Problem with downloading image: \(error.debugDescription)")
                }
               self.postedPersonImage.image = UIImage(data: data!)
                self.imgFeedCache.setObject(self.postedPersonImage.image!, forKey: url as NSString)
                //setValue(self.postedPersonImage.image, forKey: url as NSString)
            }
    }
}
