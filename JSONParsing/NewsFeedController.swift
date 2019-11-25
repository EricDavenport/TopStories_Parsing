//
//  ViewController.swift
//  JSONParsing
//
//  Created by Eric Davenport on 11/25/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import UIKit

class NewsFeedController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var headlines = [NewsHeadline]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        headlines = HeadlinesData.getHeadlines()
    }


}

extension NewsFeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath)
        
        
        return cell
    }
}
