//
//  ComposerViewController.swift
//  crumbs
//
//  Created by Colin Kohli on 8/1/15.
//  Copyright (c) 2015 Colin Kohli. All rights reserved.
//

import UIKit

class ComposerViewController: UIViewController {

    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        submitPost()
    }
    
    @IBOutlet weak var composeTextView: UITextView! = UITextView()
    var hardData = HardCodedData()
    var currentLocation: CLLocation? = nil{
        didSet{
            print(currentLocation!.coordinate.latitude)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        composeTextView.layer.borderColor = UIColor.blackColor().CGColor
        composeTextView.layer.borderWidth = 0.7
        composeTextView.layer.cornerRadius = 5
        composeTextView.becomeFirstResponder()
        
    }
    
    func submitPost(){
        
        var postText = composeTextView.text
        print(PFUser.currentUser()!.username)
        var postForSubmit: PFObject = PFObject(className: "crumbPost")
        postForSubmit.addObject(postText, forKey: "text")
        postForSubmit.addObject(PFUser.currentUser()!.username!, forKey: "user")
        postForSubmit.addObject(currentLocation!.coordinate.latitude, forKey: "latitude")
        postForSubmit.addObject(currentLocation!.coordinate.longitude, forKey: "longitude")
        postForSubmit.addObject(0, forKey: "flags")
        postForSubmit.addObject(0, forKey: "views")
        postForSubmit.saveInBackground()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
