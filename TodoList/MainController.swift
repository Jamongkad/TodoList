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

class MainController: UITabBarController, UITabBarControllerDelegate {
    
    lazy var box: UIView = UIView()
    lazy var otherBox: UIView = UIView()
    lazy var ttvc:PendingTodosTableViewController = PendingTodosTableViewController()
    

    override func viewDidLoad() {
        self.title = "Mathew Todo List"
        super.viewDidLoad()
        self.delegate = self
        
        let todoOne = Todo()
        todoOne.name = "Todo 1"
        todoOne.state = 1
        todoOne.id = 1
        
        let todoTwo = Todo()
        todoTwo.name = "Todo 2"
        todoTwo.state = 0
        todoTwo.id = 2
        
        let todoThree = Todo()
        todoThree.name = "Todo 3"
        todoThree.state = 1
        todoThree.id = 3
        
        let todoFour = Todo()
        todoFour.name = "Todo 4"
        todoFour.state = 1
        todoFour.id = 4
        
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(todoOne, update: true)
            realm.add(todoTwo, update: true)
            realm.add(todoThree, update: true)
            realm.add(todoFour, update: true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne: PendingTodosTableViewController = PendingTodosTableViewController()
        let tabOneBarItem: UITabBarItem = UITabBarItem (title: "Pending", image: nil, selectedImage: nil)
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo: DoneTodosTableViewController = DoneTodosTableViewController()
        let tabTwoBarItem: UITabBarItem = UITabBarItem (title: "Done", image: nil, selectedImage: nil)
        tabTwo.tabBarItem = tabTwoBarItem
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        NSLog("Printed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

