//
//  DoneTodosTableViewController.swift
//  TodoList
//
//  Created by Mathew Wong on 16/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit
import RealmSwift

class DoneTodosTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "cell"
    var todos:Results<Todo>?
    var realm:Realm?
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        let predicate: NSPredicate = NSPredicate(format: "state = %i", 0)
        realm = try! Realm()
        todos = realm!.objects(Todo.self).filter(predicate)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (todos?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)!
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellReuseIdentifier)
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        let todo:Todo = todos![indexPath.row]
        cell.textLabel?.text = todo.name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let myCell:UITableViewCell = (self.tableView?.cellForRowAtIndexPath(indexPath))!
        let c: CountDownHelper = CountDownHelper(table:tableView, cell:myCell, todo:todos![indexPath.row], status:1)
        c.initiateTimer()
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction: UITableViewRowAction = UITableViewRowAction.init(style: .Normal, title:"Delete") { (UITableViewRowAction, NSIndexPath) in
            NSLog("Deleted")
        }
        deleteAction.backgroundColor = UIColor.flatRedColor()
        
        return [deleteAction]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
