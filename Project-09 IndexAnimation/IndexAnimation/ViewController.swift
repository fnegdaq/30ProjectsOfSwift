//
//  ViewController.swift
//  IndexAnimation
//
//  Created by fengdaq on 2019/4/15.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    let data: [String: [String]] = ["A" : ["Apple", "Animation"],
        "B" : ["Bear", "Black Swan", "Buffalo"],
        "C" : ["Camel", "Cockatoo"],
        "D" : ["Dog", "Donkey"],
        "E" : ["Emu"],
        "G" : ["Giraffe", "Greater Rhea"],
        "H" : ["Hippopotamus", "Horse"],
        "K" : ["Koala"],
        "L" : ["Lion", "Llama"],
        "M" : ["Manatus", "Meerkat"],
        "P" : ["Panda", "Peacock", "Pig", "Platypus", "Polar Bear"],
        "R" : ["Rhinoceros"],
        "S" : ["Seagull"],
        "T" : ["Tasmania Devil"],
        "W" : ["Whale", "Whale Shark", "Wombat"]]
    var sectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionTitles = data.keys.sorted(by: {$0 < $1})
        
        let indexView = IndexView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30*sectionTitles.count))
        indexView.center = CGPoint(x: UIScreen.main.bounds.size.width - 15, y: UIScreen.main.bounds.size.height/2)
        indexView.indexArray = sectionTitles
        indexView.selectIndex = { index in
            self.tableview .selectRow(at: IndexPath.init(row: 0, section: index), animated: true, scrollPosition: UITableView.ScrollPosition.middle)
        }
        self.view.addSubview(indexView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = data[sectionTitles[section]]?.count else {
            return 0
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        let sectionTitle = sectionTitles[indexPath.section]
        if let values = data[sectionTitle] {
            cell.textLabel?.text = values[indexPath.row]
        }
        return cell
    }
    
}


