//
//  ViewController.swift
//  07_08_2023_AlarmofireDemo
//
//  Created by Vishal Jagtap on 23/10/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var postTableView: UITableView!
    var posts : [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       jsonParsingWithAlamofire()
    }
    
    func jsonParsingWithAlamofire(){
        Alamofire.request("https://jsonplaceholder.typicode.com/posts").responseJSON { response in
            
            print(response.response)
            print(response.data)
            print(response.error)
            
           let response = response.result.value as! [[String:Any]]
            print(response)
            
            for eachResponseOfPost in response{
                let postId = eachResponseOfPost["id"] as! Int
                let postUserId = eachResponseOfPost["userId"] as! Int
                let postTitle = eachResponseOfPost["title"] as! String
                let postBody = eachResponseOfPost["body"] as! String
                
                self.posts.append(
                    Post(userId: postUserId,
                         id: postId,
                         title: postTitle,
                         body: postBody)
                )
            }
            
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
    }
}
