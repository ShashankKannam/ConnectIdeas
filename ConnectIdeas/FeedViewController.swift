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
    
    @IBAction func signOut(_ sender: UIButton) {
       let keyChainResult = KeychainWrapper.standard.removeObject(forKey: "uid")
        if keyChainResult{
            FBSDKLoginManager.init().logOut()
            try! FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
        }
    }
    

    
    @IBAction func postButton(_ sender: UIButton) {
      
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
                
                for snap in snapshot{
                   // print(snap.value!)
                    if let allPostData = snap.value as? Dictionary<String, Any>{
                        print(allPostData)
                        
                       self.posts.append( PostData(personName: allPostData["personName"] as! String, personImgURL: allPostData["personImgURL"] as! String, idea: allPostData["idea"] as! String, ideaImg: allPostData["ideaImg"] as! String, postkey: allPostData["postkey"] as! String, likes: allPostData["likes"] as! String))
                    }
                }
                
            }
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostedTableViewCell") as? PostedTableViewCell{
            let post = posts[indexPath.row]
              cell.configureCell(postData: post)
             return cell
        }else{
            return PostedTableViewCell()
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            feedImage.image = selectedImage
            feedImage.roundedImage()
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    

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
