//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Waseem Idelbi on 3/15/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
}

struct SearchResults: Codable {
    let results: [SearchResult]
}

