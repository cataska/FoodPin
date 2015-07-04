//
//  Restaurant.swift
//  FoodPin
//
//  Created by Lin Wen Chun on 2015/7/3.
//  Copyright (c) 2015年 Lin Wen Chun. All rights reserved.
//

import Foundation

class Restaurant {
    
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var phone = ""
    var isVisited = false
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
}