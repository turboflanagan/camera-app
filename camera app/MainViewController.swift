//
//  MainViewController.swift
//  camera app
//
//  Created by MacBook Pro on 12/2/15.
//  Copyright © 2015 Peter Flanagan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var displayImageView: UIImageView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
