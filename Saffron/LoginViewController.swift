//
//  LoginViewController.swift
//  Saffron
//
//  Created by Erica Solum on 4/1/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import Hue
import SkyFloatingLabelTextField
import Validator
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createAccountButtin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create gradient for background
        let gradient = [UIUtils.coral, UIUtils.orange, UIUtils.yellow].gradient()
        self.view.layer.addSublayer(gradient)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
    @IBAction func loginPressed(_ sender: UIButton) {
        print("Login pressed")
        //Validate all fields first
        if let email = self.emailField.text, let password = self.passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let user = user {
                    print("We've got ourselves a live one")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        
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
