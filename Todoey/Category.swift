//
//  Category.swift
//  Todoey
//
//  Created by Joseph Anthony Castillon on 5/28/18.
//  Copyright © 2018 Joseph Anthony Castillon. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
}
