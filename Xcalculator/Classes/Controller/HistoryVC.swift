//
//  HistoryVC.swift
//  Xcalculator
//
//  Created by Abdul Azeem on 07/09/20.
//  Copyright © 2020 Mindfire. All rights reserved.
//

import UIKit
import CoreData

class HistoryVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var historyData = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.fetchHistory();
    }
    
    @IBAction func clearHistory(_ sender: UIBarButtonItem) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return};
        let managedContext = appDelegate.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Calculation");
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
            self.historyData = [];
            self.tableView.reloadData();
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchHistory(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return};
        let managedContext = appDelegate.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Calculation");
        do {
            self.historyData = try managedContext.fetch(fetchRequest);
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HistoryTVCell = tableView.dequeueReusableCell(withIdentifier: "historyCellId", for: indexPath) as! HistoryTVCell
        cell.expressionLbl.text = self.historyData[indexPath.row].value(forKey: "expression") as! String
        cell.resLbl.text = self.historyData[indexPath.row].value(forKey: "result") as! String
        return cell;
    }
    
    
}
