//
//  ChatViewController.swift
//  ChatterBox
//
//  Created by Rajeev Ram on 8/22/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ChatViewController: UIViewController, UITableViewDataSource {
    
    /*----------UI, UX Outlet Variables----------*/
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var typeMessageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTableView: UITableView!
    
    /*----------Backend Support Fields----------*/
    
    var chatMessages: [PFObject] = []
    
    /*----------ViewDidLoad() Method----------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self as UITableViewDataSource
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 50
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        chatTableView.reloadData()
    }
    
    /*----------Network Request Method----------*/
    
    @objc func retrieveChatMessages() {
        let query = PFQuery(className: "Messages")
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.chatMessages = messages
                self.chatTableView.reloadData()
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }

    /*----------Event Handlers----------*/
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
    }
    
    @IBAction func endTypingMessage(_ sender: Any) {
        view.endEditing(true);
    }
    
    @IBAction func onSend(_ sender: Any) {
        let newMessage = PFObject(className: "Messages")
        newMessage["text"] = typeMessageTextField.text ?? ""
        newMessage["user"] = PFUser.current()
        newMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.typeMessageTextField.text = ""
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    /*----------Table View Methods----------*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue a resuable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let chatMessage = chatMessages[indexPath.row]
        cell.chatMessageLabel.text = chatMessage["text"] as? String
        
        // set the username
        var identifier : String = "???"
        if let user = chatMessage["user"] as? PFUser {
            cell.usernameLabel.text = user.username
            identifier = user.username ?? "???"
        } else {
            cell.usernameLabel.text = "???"
        }
        
        // set the avatar
        let baseURL = "https://api.adorable.io/avatars/"
        let imageSize = 20
        let avatarURL = URL(string: baseURL+"\(imageSize)/\(identifier).png")
        cell.avatarImage.af_setImage(withURL: avatarURL!)
        cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.height / 2
        cell.avatarImage.clipsToBounds = true
        
        // return
        return cell;
    }
    
}
