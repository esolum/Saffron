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
import NVActivityIndicatorView

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButtin: UIButton!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create gradient for background
        let gradient = [UIUtils.coral, UIUtils.orange, UIUtils.yellow].gradient()
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
        //vc.view.backgroundColor = UIColor.orange()
        activityIndicatorView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
    @IBAction func loginPressed(_ sender: UIButton) {
        //Validate all fields first
        
        if let email = self.emailField.text, let password = self.passwordField.text {
            self.view.subviews.forEach({ $0.isHidden = true }) // this hides all the other elements so that the activity indicator shows up nicely
            
            //Start activity indicator view animation
            logoLabel.isHidden = false
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()

            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.activityIndicatorView.stopAnimating()
                    self.view.subviews.forEach({ $0.isHidden = false })
                    self.activityIndicatorView.isHidden = true
                    
                }
                if let user = user {
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
