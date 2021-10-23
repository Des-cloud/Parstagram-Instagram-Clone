//
//  ProfileViewController.swift
//  Parstagram
//
//  Created by Desmond Ofori Atta on 10/22/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var totalPosts: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        usernameLabel.text = user?.username

        let query = PFQuery(className: "Posts")
        if user != nil {
            query.whereKey("author", equalTo: user!)
            query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                if let error = error {
                    // Log details of the failure
                    print(error.localizedDescription)
                } else if objects != nil {
                    self.totalPosts.text = String(objects!.count)
                }
            }
        }
        
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        PFUser.logOut()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
}
