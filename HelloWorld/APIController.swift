//
//  APIController.swift
//  HelloWorld
//
//  Created by Dominik on 08/06/14.
//  Copyright (c) 2014 Dominik. All rights reserved.
//

import UIKit

protocol APIContollerProtocol {
    func didReceiveAPIResults(results: NSDictionary)
}

class APIController: UIViewController {
    
    var data: NSMutableData = NSMutableData()
    var delegate: APIContollerProtocol?

    init(delegate: APIContollerProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }

    
    // own stuff
    func searchItunesFor(searchTerm: String) {
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
        
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        println("Search iTunes API at URL \(url)")
        
        connection.start()
        println("here we are")
    }
    
    
    // NSURLConnectionDelegate
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Connection failed.\(error.localizedDescription)")
    }
    
    func connection(connection: NSURLConnection, didRecieveResponse response: NSURLResponse)  {
        println("Recieved response")
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!){
        // Recieved a new request, clear out the data object
        self.data = NSMutableData()
    }
    
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        // Append the recieved chunk of data to our data object
        self.data.appendData(data)
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!){
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        delegate?.didReceiveAPIResults(jsonResult)
        
    }
    

    
}
