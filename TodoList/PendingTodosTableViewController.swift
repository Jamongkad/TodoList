//
//  TodosTableViewController.swift
//  TodoList
//
//  Created by Mathew Wong on 16/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit
import RealmSwift

class PendingTodosTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "cell"
    var todos:Results<Todo>?
    var realm:Realm?
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    
        let predicate: NSPredicate = NSPredicate(format: "state = %i", 1)
        realm = try! Realm()
        todos = realm!.objects(Todo.self).filter(predicate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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
        let c: CountDownHelper = CountDownHelper(table:tableView, cell:myCell, todo:todos![indexPath.row], status:0)
        c.initiateTimer()
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction: UITableViewRowAction = UITableViewRowAction.init(style: .Normal, title:"Delete") { (UITableViewRowAction, NSIndexPath) in
            let todo:Todo = self.todos![indexPath.row]
            print("Todo \(todo)")
            try! self.realm!.write {
                self.realm!.delete(todo)
            }
            tableView.deleteRowsAtIndexPaths([NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        deleteAction.backgroundColor = UIColor.flatRedColor()
        
        return [deleteAction]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
