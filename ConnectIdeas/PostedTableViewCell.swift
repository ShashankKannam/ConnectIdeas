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
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
