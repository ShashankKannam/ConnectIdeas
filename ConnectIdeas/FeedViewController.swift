//
//  FeedViewController.swift
//  ConnectIdeas
//
//  Created by shashank kannam on 1/17/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import SwiftKeychainWrapper

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var feedImage: UIImageView!
    
    @IBOutlet weak var feedTextView: UITextView!
    
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
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
