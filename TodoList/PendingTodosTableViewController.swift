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
    var cuties:[String] = ["Mathew", "Martie", "Mickie", "Meagan", "Clemmy"]
    var todos:Results<Todo>?
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        
        let realm = try! Realm()
        let predicate: NSPredicate = NSPredicate(format: "state = %i", 1)
        todos = realm.objects(Todo.self).filter(predicate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (todos?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)!
        //if(cell == nil) {
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellReuseIdentifier)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //}
        let todo:Todo = todos![indexPath.row]
        cell.textLabel?.text = todo.name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let myCell:UITableViewCell = (self.tableView?.cellForRowAtIndexPath(indexPath))!
        
        class CountDown {
            
            var counter:Int = 5
            var myTimer:NSTimer = NSTimer()
            var myCell:UITableViewCell = UITableViewCell()
            var myTable:UITableView = UITableView()
            var myTodo:Todo?
            var realm:Realm?
            
            init(table:UITableView, cell:UITableViewCell, todo:Todo) {
                self.myTable = table
                self.myCell = cell
                self.myTodo = todo
                
                realm = try! Realm()
            }
            
            func initiateTimer() {
                myTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(CountDown.updateTimer), userInfo: nil, repeats: true)
            }
            
            @objc func updateTimer() {
                let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(CountDown.tapJustice))
                
                let button: UIButton = UIButton()
                button.setTitle(String(format: "Cancel? %is", arguments: [counter]), forState: .Normal)
                button.setTitleColor(UIColor.flatWhiteColor(), forState: .Normal)
                button.tag = 50
                button.addGestureRecognizer(tap)
                button.backgroundColor = UIColor.flatRedColor()
                self.myCell.addSubview(button)
                
                button.snp_makeConstraints { (make) in
                    make.edges.equalTo(self.myCell)
                }
                
                if(counter <= 0) {
                    myTimer.invalidate()
                    print("Stop \(self.myTodo?.name)")
                    self.revertCell()
                    let cellIndex: NSIndexPath = self.myTable.indexPathForCell(myCell)!
                    
                    try! realm!.write {
                        realm?.delete(myTodo!)
                    }
                    
                    self.myTable.deleteRowsAtIndexPaths([cellIndex], withRowAnimation: UITableViewRowAnimation.Left)
                }
                counter -= 1
            }
            
            @objc func tapJustice() {
                NSLog("Shit")
                self.revertCell()
            }
            
            func revertCell() {
                myTimer.invalidate()
                myCell.detailTextLabel?.text = ""
                for subview:UIView in self.myCell.subviews {
                    if(subview.tag == 50) {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
        
        let c: CountDown = CountDown(table:tableView, cell:myCell, todo:todos![indexPath.row])
        c.initiateTimer()
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        /*
        UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                              title:@"Edit"
                                                                            handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
            NSDictionary *ride = [rides objectAtIndex:indexPath.section];
                                                                                
            rbvc = [[RideBookingViewController alloc] init];
            [rbvc setEditedCellPath:indexPath];
            [rbvc setEditMode:YES];
            [rbvc setRideData:ride];
                                                                                
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rbvc];
            [self presentViewController:nav animated:YES completion:nil];
        }];
        [editAction setBackgroundColor:[UIColor flatBlueColor]];
        */
        
        let deleteAction: UITableViewRowAction = UITableViewRowAction.init(style: .Normal, title:"Delete") { (UITableViewRowAction, NSIndexPath) in
            NSLog("Deleted")
            /*
            self.cuties.removeAtIndex(NSIndexPath.row)
            tableView.deleteRowsAtIndexPaths([NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            */
        }
        deleteAction.backgroundColor = UIColor.flatRedColor()
        
        return [deleteAction]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
