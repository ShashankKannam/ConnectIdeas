//
//  DataService.swift
//  ConnectIdeas
//
//  Created by shashank kannam on 1/18/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService{
    
    static let dataserviceInstance = DataService()
    
    private var _dbBase = DB_BASE
    private var _dbPosts = DB_BASE.child("posts")
    private var _dbUsers = DB_BASE.child("users")
    
    //for storage
    
    private var _storagePosts = STORAGE_BASE.child("posts")
    
    var storagePosts:FIRStorageReference{
        return _storagePosts
    }
    
    var dbBase:FIRDatabaseReference{
        return _dbBase
    }
   
    var dbPosts:FIRDatabaseReference{
        return _dbPosts
    }
    
    var dbUsers:FIRDatabaseReference{
        return _dbUsers
    }
    
    
    
    func createUser(uid: String, userData: Dictionary<String, String>){
        dbUsers.child(uid).updateChildValues(userData)
        //print(userData)
    }
    
    func createPosts(postData: Dictionary<String, String>){
        dbPosts.childByAutoId().updateChildValues(postData)
    }
    
    func postKeytoUsers(uid: String,postKey: String){
      dbUsers.child(uid).updateChildValues(["postKey":"\(postKey)"])
    }
}
