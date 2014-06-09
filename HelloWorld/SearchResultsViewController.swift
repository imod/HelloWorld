//
//  SearchResultsViewController.swift
//  HelloWorld
//
//  Created by Dominik on 08/06/14.
//  Copyright (c) 2014 Dominik. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIContollerProtocol {
    
    @IBOutlet var appsTableView : UITableView
    
    var data: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
    var api: APIController?
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        api = APIController(delegate: self)
        api!.searchItunesFor("Angry Birds")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // UITableViewDataSource
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
            return tableData.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.text = rowData["trackName"] as String
        
        var urlString: NSString = rowData["artworkUrl60"] as NSString
        var imgURL: NSURL = NSURL(string: urlString)
        
        // get the image
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        cell.image = UIImage(data: imgData)
        
        var formattedPrice: NSString = rowData["formattedPrice"] as NSString

        cell.detailTextLabel.text = formattedPrice
        return cell
    }
    
    func didReceiveAPIResults(results: NSDictionary){
        if results.count>0 {
            self.tableData = results["results"] as NSArray
            self.appsTableView.reloadData()
        }
    }


}

