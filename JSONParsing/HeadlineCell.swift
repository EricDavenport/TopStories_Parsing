//
//  HeadlineCell.swift
//  JSONParsing
//
//  Created by Eric Davenport on 11/25/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {
    
    @IBOutlet weak var headlineimageView: UIImageView!
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    
    // to add corner radius on a view we need to access the layer.cornerRadius property
    // override layoutSubviews() method
    // layotSubview() gets called when the constraints and the view is getting presents in its superview
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // change the cornerRadius of the imageView's layer
        headlineimageView.layer.cornerRadius = 4 // CGFloat
    }
    
    func configureCell(for headline: NewsHeadline) {
        headlineTitleLabel.text = headline.title
    }

}
