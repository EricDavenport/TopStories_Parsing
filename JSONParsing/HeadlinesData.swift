//
//  HeadlinesData.swift
//  JSONParsing
//
//  Created by Eric Davenport on 11/25/19.
//  Copyright © 2019 Eric Davenport. All rights reserved.
//

import Foundation

// top level JSON - HeadlinesData.self because top level JSON is a dictionary
struct HeadlinesData: Codable {
    let results: [NewsHeadline] // Results represents the JSON array of stories
}


struct NewsHeadline: Codable {
    let title: String
    let abstract: String
}

extension HeadlinesData {
    // static func to retrieve headline data - parse the "TopStoriesTechnologies.json" into an array of [NewsHeadlines] objects
    static func getHeadlines() -> [NewsHeadline] {
        var headlines = [NewsHeadline]()
        
        // the app Bundle() allows access(read) our in-app resources and fikes, e.g mp3 file or in our case TopStoriesTechnology.json
        
        // get URL to intendd resource
        // here we need the url to the TopStoriesTechnology.json file
        guard let fileURL = Bundle.main.url(forResource: "TopStoriesTechnology", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            
            // parde data to our Swift [NewHeadline]
            
            let headlinesData = try JSONDecoder().decode(HeadlinesData.self, from: data)
            headlines = headlinesData.results
        } catch {
            fatalError("failed to load contents")
        }
        return headlines
    }
}
