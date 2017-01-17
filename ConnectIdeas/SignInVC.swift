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
                        }else{
                            print("error in account creation")
                        }
                    }
                }
            }
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ((FBSDKAccessToken.current()) != nil) {
            print("logged in")
            // User is logged in, do work such as go to next view controller.
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

