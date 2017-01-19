//
//  CustomView.swift
//  ConnectIdeas
//
//  Created by shashank kannam on 1/16/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit

class Customview:UIView{
    
    
}
extension UIImageView{
    func roundedImage(){
        layer.cornerRadius = self.frame.height/2
        clipsToBounds = true
    }
}
