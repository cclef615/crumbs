//
//  usernameSelect.swift
//  crumbs
//
//  Created by Colin Kohli on 8/3/15.
//  Copyright (c) 2015 Colin Kohli. All rights reserved.
//

import Foundation
import UIKit

func usernameSelect() -> UIAlertController?{
    
    
    if (PFUser.currentUser() == nil){
        
        var loginAlert: UIAlertController = UIAlertController(title: "Sign Up / Log In", message: "Please enter a username and password", preferredStyle: UIAlertControllerStyle.Alert)
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Your Handle"
            
            })
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Your Password"
            textfield.secureTextEntry = true
        })
        loginAlert.addAction(UIAlertAction(title: "Log in", style: UIAlertActionStyle.Default, handler:{
            alertAction in
            let textFields: NSArray = loginAlert.textFields! as NSArray
            let usernameTextField: UITextField = textFields.objectAtIndex(0) as! UITextField
            let passwordTextField: UITextField = textFields.objectAtIndex(1) as! UITextField
            PFUser.logInWithUsernameInBackground(usernameTextField.text as String!, password: passwordTextField.text as String!){
                (loggedInUser: PFUser?, signupError: NSError?) -> Void in
                
                if (loggedInUser != nil){
                    println("Login Success")
                   
                }
                else{
                    println("Login Failure")
                }
                
                
                }
        }))
        
        loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler:{
            alertAction in
            let textFields: NSArray = loginAlert.textFields! as NSArray
            let usernameTextField: UITextField = textFields.objectAtIndex(0) as! UITextField
            let passwordTextField: UITextField = textFields.objectAtIndex(1) as! UITextField
            
            var user: PFUser = PFUser()
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            user.signUpInBackground()
            
        }))
        
        
        return loginAlert
    
    }
    
    return nil
    
}