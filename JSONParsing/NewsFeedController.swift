//
//  ViewController.swift
//  JSONParsing
//
//  Created by Eric Davenport on 11/25/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import UIKit

enum SearchScope {
    case title      // title of the headline
    case abstract   // summary of the headline
}

class NewsFeedController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var headlines = [NewsHeadline]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.title   // default value is 0 "Title" scope
    
    // TODO: create a variable called searchQuert that calls the filter method
    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .title:
                headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
            case .abstract:
                headlines = HeadlinesData.getHeadlines().filter { $0.abstract.lowercased().contains(searchQuery.lowercased()) }
                break
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        headlines = HeadlinesData.getHeadlines()
    }
    
    // helper function
    func filterHeadlines(for searchText: String) {
        guard !searchText.isEmpty else { return }
        headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. get destination view controller
        // 2. Need indexPath the user selected from the table view
        guard let newsDetailController = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Verify class name in \"identity inspector\"")   // --->>> fatalError - used for developer errors
        }
        // 3. get the selected headline
        let headline = headlines[indexPath.row]
        
        // 4. set the newsDetailsController newsHeadline
        newsDetailController.newsHeadline = headline
    }
    
}

extension NewsFeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count    // 39 headlines
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell", for: indexPath) as? HeadlineCell else {
            fatalError("Unable to deque properly")
        }
        // get object at the current indexPath
        let currentHeadline = headlines[indexPath.row]
        
        cell.configureCell(for: currentHeadline)
        
        return cell
    }
}

extension NewsFeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension NewsFeedController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // dismiss the keyboard
        searchBar.resignFirstResponder()
    }
    
    // What happens when the search bar is empty
    
    // Real time searching as user types
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
        // searchText is empty here so we get back all the original headlines using our loadData() function
            loadData()
            return
        }
        filterHeadlines(for: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .title
            searchBar.placeholder = "search by title"
        case 1:
            currentScope = .abstract
            searchBar.placeholder = "search by abstract"
        default:
            print("not a valid search scope")
        }
    }
    
}
