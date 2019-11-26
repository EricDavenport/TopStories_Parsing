//
//  DetailViewController.swift
//  JSONParsing
//
//  Created by Eric Davenport on 11/26/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineAbstractTextView: UITextView!
    @IBOutlet weak var bylineLabel: UILabel!
    
    var newsHeadline: NewsHeadline?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        guard let headline = newsHeadline else {
            fatalError("newsHeadline is nil - verify prepare(For segue: )")
        }
    // TODO: set up image processing using URLSession() and DispatchQueue().main.async{...}
        navigationItem.title = headline.title
        headlineAbstractTextView.text = headline.abstract
        bylineLabel.text = headline.byline
    }
    
    
}
