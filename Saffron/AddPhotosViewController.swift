//
//  AddPhotosViewController.swift
//  Saffron
//
//  Created by Erica Solum on 3/16/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import Photos
import DKImagePickerController
import DZNEmptyDataSet
import RAReorderableLayout

class AddPhotosViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, RAReorderableLayoutDelegate, RAReorderableLayoutDataSource {

    //MARK: Properties
    var assets: [DKAsset]!
    var newMeal: Meal!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assets = [DKAsset]()
        
        //Set up table view to handle empty data set
        self.photoCollectionView.emptyDataSetSource = self
        self.photoCollectionView.emptyDataSetDelegate = self
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
        //self.photoTableView.rowHeight = UITableViewAutomaticDimension
        //self.photoTableView.estimatedRowHeight = 150
        newMeal = Meal()
        if let user = FirebaseUtil.getCurrentUserData() {
            newMeal.setChefID(id: user.uid)
        }
        
        nextButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Empty data set functions
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "food-icons")
        
    }
    
    func buttonImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> UIImage! {
        return UIImage(named: "choose-photos-button")
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 20.0
    }
    
    //Called when user presses the "Choose Photos" button that's added to empty set view
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        let pickerController = DKImagePickerController()
        pickerController.maxSelectableCount = 5
        pickerController.assetType = .allPhotos
        
        pickerController.didCancel = { () in
            print("User cancelled photo selection")
            self.dismiss(animated: true, completion: nil)
        }
        pickerController.showsCancelButton = true
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            //Callback happens when user dismisses view controller
            self.assets = assets
            self.photoCollectionView.reloadData()
            self.nextButton.isEnabled = true
            
        }
        self.present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: RAReorderableLayout delegate datasource
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let threePiecesWidth = floor(screenWidth / 3.0 - ((2.0 / 3) * 2))
        let twoPiecesWidth = floor(screenWidth / 2.0 - (2.0 / 2))
        if (indexPath as NSIndexPath).section == 0 {
            return CGSize(width: threePiecesWidth, height: threePiecesWidth)
        }else {
            return CGSize(width: twoPiecesWidth, height: twoPiecesWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! RACollectionViewCell
        
        let rowAsset = assets[indexPath.row]
        let thing2 = rowAsset.fetchOriginalImage(false, completeBlock: { (image, info) in
            
            
            
            cell.imageView.image = image
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, allowMoveAt indexPath: IndexPath) -> Bool {
        if collectionView.numberOfItems(inSection: (indexPath as NSIndexPath).section) <= 1 {
            return false
        }
        return true
    }
    
    /*func collectionView(_ collectionView: UICollectionView, at atIndexPath: IndexPath, didMoveTo toIndexPath: IndexPath) {
        var asset: DKAsset
        
        asset = assets.remove(at: (atIndexPath as NSIndexPath).item)
        assets.insert(asset, at: (toIndexPath as NSIndexPath).item)
        
    }*/
    
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var asset: DKAsset
        
        asset = assets.remove(at: sourceIndexPath.row)
        assets.insert(asset, at: destinationIndexPath.row)
        
        print("Thingy")
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "photosToDetails" {
            let vc = segue.destination as! MealInfoViewController
            
            vc.newMeal = newMeal
            vc.assets = assets
        }
        
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
 

}
