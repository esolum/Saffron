//
//  ChoosePhotosViewController.swift
//  Saffron
//
//  Created by Erica Solum on 3/22/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import MARoundButton
import DKImagePickerController

class ChoosePhotosViewController: UIViewController {
    
    //MARK: Properties
    var assets: [DKAsset]?
    
    @IBOutlet weak var addPhotosButton: MARoundButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    
    @IBAction func addPhotosAction(_ sender: MARoundButton) {
        let pickerController = DKImagePickerController()
        pickerController.maxSelectableCount = 5
        pickerController.assetType = .allPhotos
        
        pickerController.didCancel = { () in
            print("User cancelled photo selection")
            self.dismiss(animated: true, completion: nil)
        }
        pickerController.showsCancelButton = true
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            self.assets = assets
            print(assets)
            
            for asset in assets {
                
            }
            
            
            
        }
        self.present(pickerController, animated: true, completion: nil)
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
