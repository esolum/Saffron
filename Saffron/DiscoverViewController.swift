//
//  DiscoverViewController.swift
//  Saffron
//
//  Created by Erica Solum on 2/6/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import Firebase

class DiscoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If user is not logged in, show login controller
        if FirebaseUtil.getCurrentUserData != nil {
            // User is signed in.
            print("Signed in")
        } else {
            print("User not logged in")
            //self.performSegue(withIdentifier: "showLogin", sender: self)
            
            let vc = (
                storyboard?.instantiateViewController(
                    withIdentifier: "login")
                )!
            //vc.view.backgroundColor = UIColor.orange()
            
            present(vc, animated: true, completion: nil)
            
            
        }
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
