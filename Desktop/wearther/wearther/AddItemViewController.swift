//
//  AddItemViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/1/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var pictureView: UIImageView!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        pictureView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        
        // if there is a picture
        if let pic = self.pictureView.image {
            let imageName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("digital_closet").child("\(imageName).png")
            
            if let uploadData = UIImagePNGRepresentation(pic){
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
//                        let user = ["email": self.email.text!,
//                                    "name": self.name.text!,
//                                    "profileImageURL": profileImageURL]
//
//                        self.refUsers.child("Users").child(uid!).child(imageName).setValue(user)
                    }
                })
            }
            
        }
        
    }
    
    @IBAction func toGallery(_ sender: Any) {
    }
    
    @IBAction func openPhotos(_ sender: Any) {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            picker.delegate = self
            picker.sourceType = .photoLibrary;
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func onXOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func confirmPhotoPress(_ sender: Any) {
        performSegue(withIdentifier: "toChooseCategory", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
