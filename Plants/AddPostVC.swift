//
//  AddPostVC.swift
//  Plants
//
//  Created by Adriana Gonzalez on 2/11/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var postImg: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        titleTxt.delegate = self
        descriptionTxt.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func makePostBtnPressed(sender: AnyObject) {
        
        if let title = titleTxt.text, let desc = descriptionTxt.text, let img = postImg.image {
            let post = Post(imagePath: "", title: title, description: desc)
            DataService.instance.addPost(post)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }

    @IBAction func addPicBtnPressed(sender: UIButton) {
        sender.setTitle("", forState: UIControlState.Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
