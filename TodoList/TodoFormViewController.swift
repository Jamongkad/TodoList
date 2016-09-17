//
//  TodoFormViewController.swift
//  TodoList
//
//  Created by Mathew Wong on 17/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework
import RealmSwift

class TodoFormViewController: UIViewController, UITextFieldDelegate {
    
    var todoTextField:UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.flatWhiteColor()
        
        let cancelBtn: UIBarButtonItem = UIBarButtonItem (barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(self.cancel))
        self.navigationItem.setLeftBarButtonItem(cancelBtn, animated: false)
        
        let insertTodoBtn: UIBarButtonItem = UIBarButtonItem(title: "Add Todo", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.insertTodo))
        self.navigationItem.setRightBarButtonItem(insertTodoBtn, animated: false)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        self.title = "Create Todo"
        
        todoTextField = UITextField()
        todoTextField!.backgroundColor = UIColor.whiteColor()
        todoTextField!.attributedPlaceholder = NSAttributedString(string: "Take out trash, etc.", attributes: nil)
        todoTextField!.layer.sublayerTransform = CATransform3DMakeTranslation(21, 0, 0)
        todoTextField!.delegate = self
        self.view.addSubview(todoTextField!)
        
        todoTextField!.snp_makeConstraints { (make) in
            make.height.equalTo(40)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(70)
        }
    }
    
    func insertTodo() {
        print(todoTextField?.text)
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
