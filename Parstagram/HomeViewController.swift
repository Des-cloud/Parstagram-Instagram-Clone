//
//  HomeViewController.swift
//  Parstagram
//
//  Created by Desmond Ofori Atta on 10/21/21.
//

import UIKit
import Parse
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var posts = [PFObject]()
    var postLimit : Int!
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
//        loadPosts()
        refresh.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPosts()
    }
    
    @objc func loadPosts(){
        postLimit = 10
        
        let user = PFUser.current()
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = postLimit
        
        print(user!)
        if user != nil {
            query.whereKey("author", equalTo: user!)
            query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
                if let error = error {
                    // Log details of the failure
                    print(error.localizedDescription)
                } else if posts != nil {
                    self.posts = posts!
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func loadMorePosts(){
        postLimit = postLimit + 20
        
        let user = PFUser.current()
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = postLimit
        
        if user != nil {
            query.whereKey("author", equalTo: user!)
            query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
                if let error = error {
                    // Log details of the failure
                    print(error.localizedDescription)
                } else if posts != nil {
                    self.posts.removeAll()
                    for post in posts! {
                        self.posts.append(post)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count {
            loadMorePosts()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let post = posts[indexPath.row]
        
        cell.author.text = (post["author"] as! PFUser).username
        cell.caption.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let url = URL(string: imageFile.url!)
        
        cell.postImage.af.setImage(withURL: url!)
        
        return cell
    }

}
