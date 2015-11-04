//
//  ViewController.swift
//  Topcoder-FunSeries-SurveyApp
//
//  Created by Harshit on 24/09/15.
//  Copyright (c) 2015 topcoder. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate {
    
    
    var dataArray:NSMutableArray!
    var plistPath:String!
    var tableData: NSArray!
    var filteredData: [String] = []
    var titleData :[String] = []
    var i: Int = 0
    var flag: Bool = false;

    @IBOutlet var SurveyTableSearchBar: UISearchBar!
    
    
    @IBOutlet var Label: UILabel!
    @IBOutlet var SurveyTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SurveyTable.delegate=self;
        SurveyTable.dataSource=self;
        
        
        //Do any additional setup after loading the view, typically from a nib.
        /*if let path = NSBundle.mainBundle().pathForResource("data", ofType: "plist"){
            if let arrayOfDictionaries = NSArray(contentsOfFile: path){
                for dict in arrayOfDictionaries {
                    tableData.append(dict.objectForKey("title") as! String)
                }
            }
        }
        print(tableData);*/
        
        var JSONData:NSData = getJSON("http://www.mocky.io/v2/560920cc9665b96e1e69bb46")
        
        tableData = parseJSON(JSONData)
        println(tableData) // show me data
        SurveyTable.reloadData()
        
        for(i=0; i < tableData.count ; i++)
        {
            var temp: String;
            temp = (tableData[i]["title"] as? String)!;
            titleData.insert(temp, atIndex: i);
            
        }
        println(titleData);
        //filteredData = titleData
        

    }
    
    //Search Bar functions
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        println("india");
        flag = true;
        self.filteredData = self.titleData.filter({ (title : String) -> Bool in
            let stringForSearch = title.rangeOfString(searchText)
            return (stringForSearch != nil)
        })
       SurveyTable.reloadData()
    }
    
    
    
    
 
    
   //JSON Parsing and API hit functions
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    
    func parseJSON(inputData: NSData) -> NSArray{
        var error: NSError?
        var data: NSArray = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        
        return data
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(SurveyTable: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(SurveyTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (flag == false)
        {
        return titleData.count;
        }
            else
        {
        return filteredData.count;
        }
        
    }
    
   func tableView(SurveyTable: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            
            /*
            var selected : String!
            // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
            if (SurveyTable == self.searchDisplayController!.searchResultsTableView) {
                
                selected = filteredData[indexPath.row]
            } else {
                selected = titleData[indexPath.row]
            }
           */
            
            let cell1 = SurveyTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            
            var countryName : String!
            if (flag == true) {
                countryName = filteredData[indexPath.row]
            } else {
                countryName = titleData[indexPath.row]
            }
            
            cell1.textLabel?!.text = countryName
            
            return cell1 as! UITableViewCell
    }
    
    
    
}


