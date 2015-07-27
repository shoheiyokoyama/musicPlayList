//
//  PlayListViewController.swift
//  MusicPlayer
//
//  Created by Shohei Yokoyama on 2015/07/27.
//  Copyright (c) 2015年 Shohei. All rights reserved.
//

import UIKit

class PlayListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var tableView: UITableView!
    private var testItems = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        tableView = UITableView(frame: CGRectMake(0.0, barHeight, self.view.frame.width, self.view.frame.height - barHeight), style: .Grouped)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView( tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
        
        return testItems.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Num: \(indexPath.row)")
        println("Value: \(testItems[indexPath.row])")
    }
    
    func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = "\(testItems[indexPath.row])"
        
        return cell
    }
}

