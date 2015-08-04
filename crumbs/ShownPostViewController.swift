//
//  ShownPostViewController.swift
//  crumbs
//
//  Created by Colin Kohli on 7/27/15.
//  Copyright (c) 2015 Colin Kohli. All rights reserved.
//

import UIKit

class ShownPostViewController: UIViewController {

    
    

    
    @IBOutlet weak var postUser: UILabel!
    @IBOutlet weak var postText: UILabel!
   
    var receivedUserString: String = "Loading..."
    var receivedPostString: String = "Loading..."

    
    override func viewWillAppear(animated: Bool) {
        print("ping")
        super.viewWillAppear(true)
        postText.text = " \" \(receivedPostString) \" "
        postUser.text = "\(receivedUserString):"
    }
    
    @IBAction func unwindToFeed(segue: UIStoryboardSegue) {
    
    
    }
    
    
    
}
