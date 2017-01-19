//
//  PostedTableViewCell.swift
//  ConnectIdeas
//
//  Created by shashank kannam on 1/18/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit

class PostedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var personImage: UIImageView!
    
    
    @IBOutlet weak var personName: UILabel!
    
    
    @IBOutlet weak var postedPersonImage: UIImageView!
    
    
    @IBOutlet weak var postedPersonTextView: UITextView!
    
    @IBOutlet weak var Likes: UILabel!
    
    @IBAction func likeButton(_ sender: UIButton) {
      
        
    }
    
    
    func configureCell(postData: PostData){
       personName.text = postData.personName
       postedPersonTextView.text = postData.idea
       Likes.text = postData.likes
    print("Herre ...................................")
        print(Likes.text)
        
        downloadImages(url: postData.personImgURL)
        downloadImages(url: postData.ideaImg)
    }
    
    
    func downloadImages(url: String){
       personImage.roundedImage()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
