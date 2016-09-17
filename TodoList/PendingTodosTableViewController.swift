//
//  TodosTableViewController.swift
//  TodoList
//
//  Created by Mathew Wong on 16/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit
import RealmSwift

class PendingTodosTableViewController: TodoTableViewController {
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        let predicate: NSPredicate = NSPredicate(format: "state = %i", 1)
        realm = try! Realm()
        todos = realm!.objects(Todo.self).filter(predicate)
        
        //set state for todo done!
        self.state = 0
    }
}
