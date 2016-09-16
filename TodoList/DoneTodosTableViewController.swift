//
//  DoneTodosTableViewController.swift
//  TodoList
//
//  Created by Mathew Wong on 16/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit

class DoneTodosTableViewController: UITableViewController {
    
    let cellReuseIdentifier = "cell"
    let cuties:[String] = ["Pod", "Irene", "RX-7", "Macbook Pro", "iPhone 7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.clearColor()
        //self.tableView.separatorStyle = .None
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cuties.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = cuties[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("Selected %@", cuties[indexPath.row])
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
        }
        deleteAction.backgroundColor = UIColor.flatRedColor()
        
        return [deleteAction]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
