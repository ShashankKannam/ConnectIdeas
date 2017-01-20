//
//  PostData.swift
//  ConnectIdeas
//
//  Created by shashank kannam on 1/18/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import Foundation

struct PostData{
    private var _personName:String!
    private var _personImgURL:String!
    private var _idea:String!
    private var _ideaImg:String!
    private var _postkey:String!
    private var _likes:String!
    private var _uid:String!
    
    var personName:String{
        return _personName
    }
    
    var personImgURL:String{
        return _personImgURL
    }
    
    var idea:String{
        return _idea
    }
    
    var ideaImg:String{
        return _ideaImg
    }
    
    var postkey:String{

        return _postkey
    }
    
    var likes:String{
        set{
            _likes = newValue
        }
        get{
          return _likes  
        }
    }
    
    var uid:String{
        return _uid
    }
    
    init(personName:String, personImgURL:String, idea:String, ideaImg:String, postkey:String, likes:String, uid:String){
        _personName = personName
        _personImgURL = personImgURL
        _idea = idea
        _ideaImg = ideaImg
        _likes = likes
        _postkey = postkey
        _uid = uid
    }
    
}
