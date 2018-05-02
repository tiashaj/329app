//
//  RegisterViewController.swift
//  wearther
//
//  Created by Amy Fang on 3/22/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    var refUsers: DatabaseReference!
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setupProfileImageView() {
        //need x, y, width, height constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: name.topAnchor, constant: -20).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileImageView)
        setupProfileImageView()
        
        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        refUsers = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func register(_ sender: Any) {
        if email.text!.isEmpty || password.text!.isEmpty || name.text!.isEmpty {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter your name, email, and password", preferredStyle: .alert)
                
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            displayAlert(alertController: alertController)
        }
        else if !isValidPassword(password: password.text!) {
            let alertController = UIAlertController(title: "Error", message: "Please enter a password with at least 8 characters", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            displayAlert(alertController: alertController)
        }
        else if !passwordsMatch(password: password.text!, confirmPassword: confirmPassword.text!) {
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            displayAlert(alertController: alertController)
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                if error == nil {
                    
                    let uid = user?.uid
                    
                    // Successfully authenticated user
                    let imageName = UUID().uuidString
                    let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
                    
                    if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!){
                        storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                            if let error = error {
                                print(error)
                                return
                            }
                            
                            if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                                let user = ["email": self.email.text!,
                                            "name": self.name.text!,
                                            "profileImageURL": profileImageURL]
                            
                                self.refUsers.child("Users").child(uid!).setValue(user)
                            }
                        })
                    }
                    
                    //Goes to the Home page
                    self.performSegue(withIdentifier: "home", sender: self)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                        
                    self.displayAlert(alertController: alertController)
                }
            })
        }
    }
    
    func displayAlert(alertController: UIAlertController) {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func isValidPassword (password:String) -> Bool {
        return (password.count >= 8)
    }
    
    func passwordsMatch (password:String, confirmPassword:String) -> Bool {
        return (password == confirmPassword)
    }
    
    @IBAction func segueToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "registerToLogin", sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MyTabBarController {
            destinationVC.user_email = email.text
        }
    }
    */

}
