//
//  FeedViewController.swift
//  ConnectIdeas
//
//  Created by shashank kannam on 1/17/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import SwiftKeychainWrapper

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
     @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var feedImage: UIImageView!
    
    @IBOutlet weak var feedTextView: UITextView!
    
    
    var posts:[PostData]!
    
    var imagePicker:UIImagePickerController!
    
    var imageSelected = false
  
    
    @IBAction func signOut(_ sender: UIButton) {
       let keyChainResult = KeychainWrapper.standard.removeObject(forKey: "uid")
        if keyChainResult{
            FBSDKLoginManager.init().logOut()
            try! FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
        }
    }
    

    
    @IBAction func postButton(_ sender: UIButton) {
     
        guard let feedText = feedTextView.text, feedText != "" else{
            print("text is nil")
            return
        }
        
        guard let feedImageguarded = feedImage.image, imageSelected == true else{
            print("image not selected")
            return
        }

            if let imgData = UIImageJPEGRepresentation(feedImageguarded, 0.2){
                let imgUID = UUID.init().uuidString
                let metaData = FIRStorageMetadata()
                metaData.contentType = "image/jpeg"
                DataService.dataserviceInstance.storagePosts.child(imgUID).put(imgData, metadata: metaData, completion: { (uploadMetaData, error) in
                    if error != nil{
                        print("Cant upload images to firebase: \(error.debugDescription)")
                    }else{
                        print("succesfully uploaded img")
                        if let downloadURL = uploadMetaData?.downloadURL()?.absoluteString{
                          print(downloadURL)
                            self.uploadPostData(url: downloadURL)
                        }
                    }
                })
            }
    }
    
    
    func uploadPostData(url: String){
        let currentUserIMgURL = FIRAuth.auth()?.currentUser?.photoURL?.absoluteString
        let currentUsername = FIRAuth.auth()?.currentUser?.displayName
        var postUID:String = ""
        if let postUID1 = FIRAuth.auth()?.currentUser?.uid{
            postUID = postUID1
        }
   if let feedtxt = feedTextView.text, let personImgURL = currentUserIMgURL, let personName = currentUsername{
           DataService.dataserviceInstance.createPosts(postData: ["idea":"\(feedtxt)", "ideaImg":"\(url)", "likes":"0", "personImgURL":"\(personImgURL)", "personName":"\(personName)", "postkey":"\(postUID)"])
        }
        feedTextView.text = ""
    }
    
    
    
    
    
    @IBAction func uploadImageBuuton(_ sender: UIButton) {
       self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        posts = [PostData]()
        
        downloadAllPosts()
        // Do any additional setup after loading the view.
    }

    
    func downloadAllPosts(){
     
        DataService.dataserviceInstance.dbPosts.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{
                self.posts = []
                for snap in snapshot{
                   // print(snap.value!)
                    if let allPostData = snap.value as? Dictionary<String, Any>{
                       // print(allPostData)
                        
                        self.posts.append( PostData(personName: allPostData["personName"] as! String, personImgURL: allPostData["personImgURL"] as! String, idea: allPostData["idea"] as! String, ideaImg: allPostData["ideaImg"] as! String, postkey: allPostData["postkey"] as! String, likes: allPostData["likes"] as! String, uid: allPostData["uid"] as! String))
                    }
                }
            }
            self.posts.reverse()
            self.tableView.reloadData()
        })
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostedTableViewCell") as? PostedTableViewCell{
              cell.configureCell(postData: post)
             return cell
        }else{
            return PostedTableViewCell()
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            feedImage.image = selectedImage
            imageSelected = true
            feedImage.roundedImage()
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        tableView.reloadData()
//    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        tableView.reloadData()
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
