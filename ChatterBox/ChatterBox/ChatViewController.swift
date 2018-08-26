//
//  ChatViewController.swift
//  ChatterBox
//
//  Created by Rajeev Ram on 8/22/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UI, UX Outlet Variables
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var typeMessageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTableView: UITableView!
    
    // Backend Logic, Instance Variables
    var chatMessages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self as UITableViewDelegate
        chatTableView.dataSource = self as UITableViewDataSource
        chatTableView.rowHeight = 50
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveChatMessages), userInfo: nil, repeats: true)
        chatTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Event Handlers
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
    }
    
    @IBAction func onSend(_ sender: Any) {
        let newMessage = PFObject(className: "Messages")
        newMessage["text"] = typeMessageTextField.text ?? ""
        newMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.typeMessageTextField.text = ""
            } else if let error = error {
                print((error.localizedDescription))
            }
        }
    }
    
    // Query, Refresh Timer Method
    
    @objc func retrieveChatMessages() {
        let query = PFQuery(className: "Messages")
        query.addDescendingOrder("createdAt")
        query.limit = 20
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
    
    // Delegate Protocol Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let chatMessage = chatMessages[indexPath.row]
        cell.chatMessageLabel.text = chatMessage["text"] as? String
        return cell;
    }
    
}
