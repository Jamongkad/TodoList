//
//  CountDownHelper.swift
//  TodoList
//
//  Created by Mathew Wong on 17/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit
import RealmSwift

class CountDownHelper: NSObject {

    var counter:Int = 5
    var myTimer:NSTimer = NSTimer()
    var myCell:UITableViewCell = UITableViewCell()
    var myTable:UITableView = UITableView()
    var myTodo:Todo?
    var realm:Realm?
    var button: UIButton = UIButton()
    var status:Int = 0
    
    init(table:UITableView, cell:UITableViewCell, todo:Todo, status:Int) {
        super.init()
        
        self.myTable = table
        self.myCell = cell
        self.myTodo = todo
        self.status = status
        
        realm = try! Realm()
    }
    
    func initiateTimer() {
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.tapJustice))
        if(self.status == 1) {
            button.setTitle("Todo is Pending.", forState: .Normal)
            button.backgroundColor = UIColor.flatBlueColor()
        } else {
            button.setTitle("Todo is Done!", forState: .Normal)
            button.backgroundColor = UIColor.flatRedColor()
        }
       
        
        button.setTitleColor(UIColor.flatWhiteColor(), forState: .Normal)
        button.tag = 50
        button.addGestureRecognizer(tap)
        button.alpha = 0
        
        self.myCell.addSubview(button)
        
        button.fadeIn(0.4)
        
        button.snp_makeConstraints { (make) in
            make.edges.equalTo(self.myCell)
        }
    }
    
    func updateTimer() {
        button.setTitle(String(format: "Cancel? %is", arguments: [counter]), forState: .Normal)
        if(counter <= 0) {
            myTimer.invalidate()
            print("Stop \(self.myTodo?.name)")
            self.revertCell()
            let cellIndex: NSIndexPath = self.myTable.indexPathForCell(myCell)!
            
            try! realm!.write {
                myTodo?.state = self.status
                realm?.add(myTodo!, update: true)
            }
            
            self.myTable.deleteRowsAtIndexPaths([cellIndex], withRowAnimation: UITableViewRowAnimation.Left)
        }
        counter -= 1
    }
    
    func tapJustice() {
        self.revertCell()
    }
    
    func revertCell() {
        myTimer.invalidate()
        myCell.detailTextLabel?.text = ""
        button.fadeOut(0.4, callback: {
            for subview:UIView in self.myCell.subviews {
                if(subview.tag == 50) {
                    subview.removeFromSuperview()
                }
            }
        })
    }
}
