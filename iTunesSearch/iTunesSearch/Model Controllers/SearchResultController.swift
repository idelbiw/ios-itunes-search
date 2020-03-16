//
//  SearchResultController.swift
//  iTunesSearch
//
//  Created by Waseem Idelbi on 3/15/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import Foundation

class SearchResultController {
    
    //MARK: -Properties-
    
    private let baseURL = URL(string: "https://itunes.apple.com/search?parameterkeyvalue")!
    var searchResults: [SearchResult] = []
    
    //    enum HTTPMethod: String {
    //        case get = "GET"
    //        case put = "PUT"
    //        case post = "POST"
    //        case delete = "DELETE"
    //    }
    
    //MARK: -Methods-
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        guard let requestURL = urlComponents?.url else {return}
        //        var request = URLRequest(url: requestURL)
        //request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            guard error == nil else {
                completion(error)
                return
            }
            guard let data = data else {
                completion(NSError())
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let decodedResult = try decoder.decode([SearchResult].self, from: data)
                self.searchResults = decodedResult
                completion(nil)
            } catch {
                print("Could not decode data: \(error)")
                completion(error)
            }
        }.resume()
    }
    
} //End of class
