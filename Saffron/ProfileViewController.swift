//
//  ProfileViewController.swift
//  Saffron
//
//  Created by Erica Solum on 2/6/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button actions
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        do {
            try FIRAuth.auth()?.signOut()
            if let user = FirebaseUtil.getCurrentUserData() {
                print("Something's wrong")
            }
            let vc = (
                storyboard?.instantiateViewController(
                    withIdentifier: "login")
                )!
            present(vc, animated: true, completion: nil)
        } catch let error as Error {
            print(error.localizedDescription)
        }
        
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
