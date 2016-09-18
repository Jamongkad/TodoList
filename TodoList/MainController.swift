//
//  ViewController.swift
//  TodoList
//
//  Created by Mathew Wong on 15/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit
import RealmSwift
import Alamofire
import SwiftyJSON
import LilithProgressHUD

class MainController: UITabBarController, UITabBarControllerDelegate {
    
    let tabOne: PendingTodosTableViewController = PendingTodosTableViewController()
    let tabTwo: DoneTodosTableViewController  = DoneTodosTableViewController()
    
    override func viewDidLoad() {
        self.title = "Mathew Todo List"
        super.viewDidLoad()
        self.delegate = self
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "name CONTAINS[c] %@", "task")
        let stockTodos:Results<Todo> = realm.objects(Todo.self).filter(predicate)
        //print(stockTodos)
        
        let addBtn: UIBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.openTodoForm))
        self.navigationItem.setRightBarButtonItem(addBtn, animated: false)
        
        if stockTodos.count == 0 {
            LilithProgressHUD.show()
            Alamofire.request(.GET, "https://dl.dropboxusercontent.com/u/6890301/tasks.json") .responseJSON { response in
                if let jsonResponse = response.result.value {
                    //print("JSON: \(jsonResponse)")
                    let json = JSON(jsonResponse)

                    for (key,subJson):(String, JSON) in json {
                        var i = 0
                        while i < subJson.count {
                            try! realm.write {
                                let todo:Todo = Todo()
                                todo.name = subJson[i]["name"].string!
                                todo.state = subJson[i]["state"].int!
                                todo.id = NSUUID().UUIDString
                                realm.add(todo)
                            }
                            i = i + 1
                        }
                    }
                    LilithProgressHUD.hide()
                    self.tabOne.tableView.reloadData()
                }
            }
        }
    }
    
    func openTodoForm() {
        let tfvc:TodoFormViewController = TodoFormViewController()
        let nav:UINavigationController = UINavigationController(rootViewController:tfvc)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOneBarItem: UITabBarItem = UITabBarItem (title: "Pending", image: UIImage(named: "pending-mark"), selectedImage: nil)
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwoBarItem: UITabBarItem = UITabBarItem (title: "Done", image: UIImage(named: "done-mark"), selectedImage: nil)
        tabTwo.tabBarItem = tabTwoBarItem
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        //NSLog("Printed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

