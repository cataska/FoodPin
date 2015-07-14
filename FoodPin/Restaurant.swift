//
//  Restaurant.swift
//  FoodPin
//
//  Created by Lin Wen Chun on 2015/7/3.
//  Copyright (c) 2015年 Lin Wen Chun. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {
    
    @NSManaged var name: String!
    @NSManaged var type: String!
    @NSManaged var location: String!
    @NSManaged var image: NSData!
    @NSManaged var isVisited: NSNumber!
}