//
//  HardCoadedPosts.swift
//  crumbs
//
//  Created by Colin Kohli on 7/22/15.
//  Copyright (c) 2015 Colin Kohli. All rights reserved.
//

import Foundation

class HardCodedData{
    
    var UserID = "ColinjKohli"


    var posts: [Int : Post] =
        
    [
        0 : Post(myUser: "Hansel", myText: "1", myLATT: 1.0, myLONG: 1.0, myViews: 3, myFlags: 0),
        
        1 : Post(myUser: "Gretel", myText: "Let's Follow Them!", myLATT: 1.0, myLONG: 1.0, myViews: 3, myFlags: 0)
    ]
    
    var myPosts: [Int : Post] =
    
    [
        0 : Post(myUser: "Me", myText: "I've only posted one thing!", myLATT: 1.0, myLONG: 1.0, myViews: 3, myFlags: 3)
    ]
    
}