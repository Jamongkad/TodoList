//
//  Todos.swift
//  TodoList
//
//  Created by Mathew Wong on 16/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit
import RealmSwift

class Todo: Object {
    dynamic var name = ""
    dynamic var state = 0
    dynamic var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}