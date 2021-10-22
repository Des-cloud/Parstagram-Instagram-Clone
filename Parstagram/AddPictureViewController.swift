//
//  AddPictureViewController.swift
//  Parstagram
//
//  Created by Desmond Ofori Atta on 10/22/21.
//

import UIKit
import AlamofireImage
import Parse

class AddPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let screenRect = UIScreen.main.bounds
    
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var captionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onShare(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["caption"] = captionField.text == "Caption" ? "" : captionField.text
        post["author"] = PFUser.current()!
        
        let imageData = imageField.image!.pngData()
        let imageFile = PFFileObject(name: "image.png", data: imageData!)
        
        post["image"] = imageFile
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
            else{
                print("\(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func onCameraPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 800)
        let scaledImage = image.af.imageScaled(to: size)
        
        imageField.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
