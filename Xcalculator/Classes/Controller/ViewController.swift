//
//  ViewController.swift
//  Xcalculator
//
//  Created by Abdul Azeem on 24/08/20.
//  Copyright © 2020 Mindfire. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var expressionTxtView: UITextView!;
    @IBOutlet var resLabel: UILabel!;
    @IBOutlet var menuView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        self.menuView.isHidden = true;
        self.expressionTxtView.textContainer.maximumNumberOfLines = 1;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func input(_ sender: UIButton) {
        let currentInput = sender.titleLabel!.text!;
        if(currentInput == "="){
            self.saveData(expression: self.expressionTxtView.text, result: self.resLabel.text!)
            self.expressionTxtView.font = .systemFont(ofSize: 50)
            self.expressionTxtView.text = self.resLabel.text;
            self.resLabel.text = "";
        }
        else{
            self.expressionTxtView.text += currentInput;
        }
        if(Character(currentInput).isNumber) {
            let result = CppWrapper().evaluate(self.expressionTxtView.text);
            self.resLabel.text = result - floor(result) == 0 ? "\(Int(result))" : "\(result)";
        }
        if(self.expressionTxtView.textStorage.size().width >= self.expressionTxtView.frame.width){
            self.expressionTxtView.font = .systemFont(ofSize: self.expressionTxtView.font!.pointSize - 10)
        }
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        self.expressionTxtView.text = "";
        self.resLabel.text = "";
        self.expressionTxtView.font = .systemFont(ofSize: 50)
    }
    
    @IBAction func menuButton(_ sender: UIButton) {
        self.menuView.isHidden = self.menuView.isHidden ? false : true;
    }
    
    @IBAction func themeToggle(_ sender: UIButton) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return}
        let sceneDelegate = windowScene.delegate as? SceneDelegate
        if(sender.titleLabel?.text == "Dark-theme"){
            sceneDelegate?.window?.overrideUserInterfaceStyle = .dark;
            sender.setTitle("Light-theme", for: .normal);
        }
        else{
            sceneDelegate?.window?.overrideUserInterfaceStyle = .light;
            sender.setTitle("Dark-theme", for: .normal);
        }
    }
    
    func saveData(expression:  String, result: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managedContext = appDelegate.persistentContainer.viewContext;
        let entity = NSEntityDescription.entity(forEntityName: "Calculation", in: managedContext)!;
        let calculation = NSManagedObject(entity: entity, insertInto: managedContext);
        calculation.setValue(expression, forKey: "expression");
        calculation.setValue(result, forKey: "result");
        do {
            try managedContext.save();
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)");
        }
    }
    
}

