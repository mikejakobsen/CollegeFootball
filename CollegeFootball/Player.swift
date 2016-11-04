//
//  Player.swift
//  CollegeFootball
//
//  Created by Kaj Schermer Didriksen on 07/10/2016.
//  Copyright © 2016 Kaj Schermer Didriksen. All rights reserved.
//

import UIKit


struct Player {
    let name: String
    let college: String
    let imageURL: String
    
    var image: UIImage?
    
    init(name: String, college: String, imageURL: String) {
        self.name = name
        self.college = college
        self.imageURL = imageURL
        self.image = nil
    }
    
}
