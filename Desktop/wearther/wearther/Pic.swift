//
//  Pic.swift
//  wearther
//
//  Created by Amy Fang on 5/2/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Pic {
    let key:String!
    let url:String!
    
    let itemRef:DatabaseReference?
    
    init(url:String, key:String) {
        self.key = key
        self.url = url
        self.itemRef = nil
    }
    
    init(snapshot:DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let imageURL = snapshotValue?["url"] as? String {
            url = imageURL
            print(url)
        } else {
            url = ""
            print(url)
        }
    }
}

