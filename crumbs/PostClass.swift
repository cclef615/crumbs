//
//  postClass.swift
//  crumbs
//
//  Created by Colin Kohli on 7/22/15.
//  Copyright (c) 2015 Colin Kohli. All rights reserved.
//

import Foundation


class Post{

    init(myUser: String, myText: String, myLATT: Float, myLONG:Float, myViews: Int,  myFlags: Int){
        
       User = myUser
       Text = myText
       LATT = myLATT
       LONG = myLONG
        Flags = myFlags
        Views = myViews
    
        }
    
    
    var User: String
    var Text: String
    var LATT: Float
    var LONG: Float
    var Views: Int
    var Flags: Int

}