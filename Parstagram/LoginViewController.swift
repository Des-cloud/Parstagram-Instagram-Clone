//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Desmond Ofori Atta on 10/21/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.usernameField.frame.height))
        usernameField.leftView = paddingView
        usernameField.leftViewMode = .always
        
        let passwordView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.passwordField.frame.height))
        passwordField.leftView = passwordView
        passwordField.leftViewMode = .always
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }

    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                let err = error.localizedDescription
                print(err)
            } else {
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground:usernameField.text!, password:passwordField.text!) {
          (user: PFUser?, error: Error?) -> Void in
          if user != nil {
              UserDefaults.standard.set(true, forKey: "userLoggedIn")
              self.performSegue(withIdentifier: "loginSegue", sender: nil)
          } else {
            print("Invalid username or password")
          }
        }

    }
}
