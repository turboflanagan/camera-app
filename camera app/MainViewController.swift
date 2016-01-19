//
//  MainViewController.swift
//  camera app
//
//  Created by MacBook Pro on 12/2/15.
//  Copyright © 2015 Peter Flanagan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    private var imageStore : [UIImage]!
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let image = self.imageStore[indexPath.item]
        self.displayImageView.image = image
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let image = self.imageStore![indexPath.item]
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PreviewCellReuseID", forIndexPath: indexPath) as? PreviewCollectionViewCell {
            cell.previewImageView.image = image
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageStore.count
    }
    
    @IBAction func cameraButtonTouched(sender: UIBarButtonItem) {
        
        self.displayImagePicker(.Camera)
    }
    
    
    
    @IBAction func libraryButtonTouched(sender: UIBarButtonItem) {
        
        self.displayImagePicker(.PhotoLibrary)
    }
    
    @IBAction func actionButtonTouched(sender: AnyObject) {
        if let image = self.displayImageView.image{
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityViewController.excludedActivityTypes = [UIActivityTypeMail]
            self.presentViewController(activityViewController, animated: true,
                completion:nil)
        }
    }
    
    func displayImagePicker(sType:UIImagePickerControllerSourceType) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sType
        
        imagePicker.delegate = self
        
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.displayImageView.image = image
        self.imageStore.insert(image, atIndex: 0)
        self.previewCollectionView.reloadData()
        self.previewCollectionView.alpha = 1.0
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FilterSegue" {
            if let vc : FilterViewController = segue.destinationViewController as? FilterViewController {
                vc.sourceImage = self.displayImageView.image
            }
        }
    }
    
    
    @IBAction func didSelectFilter(segue: UIStoryboardSegue) {
        if segue.identifier == "FilterSelectedSegue" {
            if let source = segue.sourceViewController as? FilterViewController, let image = source.filteredImage {
                self.displayImageView.image = image
            }
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        self.previewCollectionView.alpha = 0.0
        self.imageStore = [UIImage]()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var displayImageView: UIImageView!

    @IBOutlet weak var previewCollectionView: UICollectionView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
