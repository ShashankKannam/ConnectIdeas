//
//  ViewController.swift
//  ConnectIdeas
//
//  Created by shashank kannam on 1/16/17.
//  Copyright © 2017 shashank kannam. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailIDTF:UITextField!
    
    @IBOutlet weak var passwordTF:UITextField!
    
    
    @IBAction func login(_ sender: Any){
      
        print("Got here first...")
        let fbloginManager = FBSDKLoginManager()
      fbloginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
        if error != nil{
            print("Unable to login \(error?.localizedDescription)")
        }
        else if result?.isCancelled == true{
            print("Not giving Permissions")
        }
        else {
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                // ...
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("The on who logged in ............")
                print((user?.displayName)! as String)
                if let user = user{
                    self.completeSignInkeychain(uid: user.uid)
                }
        }
        }
    }
    }

    
    @IBAction func emailLogin(_ sender: Any){
       
        if let email = emailIDTF.text, let password = passwordTF.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                // ...
                if error == nil{
                   print("successfully logged in")
                   
                }
                else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                        // ...
                        if error == nil{
                             print("account created")
                            if let user = user{
                             self.completeSignInkeychain(uid: user.uid)
                            }
                        }else{
                            print("error in account creation")
                        }
                    }
                }
            }
        }
    }
    
   
    func completeSignInkeychain(uid: String){
       KeychainWrapper.standard.set(uid, forKey: "uid")
        performSegue(withIdentifier: "goToFeed", sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedVC =  (self.storyboard?.instantiateViewController(withIdentifier: "FeedVC"))! as UIViewController
        self.present(feedVC, animated: true, completion: nil)

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
        
        if ((FBSDKAccessToken.current()) != nil) {
            print("logged in")
            // User is logged in, do work such as go to next view controller.
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        
        
    }

}

