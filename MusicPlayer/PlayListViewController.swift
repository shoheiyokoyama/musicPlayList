//
//  PlayListViewController.swift
//  MusicPlayer
//
//  Created by Shohei Yokoyama on 2015/07/27.
//  Copyright (c) 2015年 Shohei. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class PlayListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var albums: [AlbumInfo] = []
    var songQuery: MusicQuery = MusicQuery()
    var audio: AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        tableView = UITableView(frame: CGRectMake(0.0, barHeight, self.view.frame.width, self.view.frame.height - barHeight), style: .Grouped)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self;
        tableView.dataSource = self;
        self.view.addSubview(tableView)
        
        let stopButton: UIBarButtonItem = UIBarButtonItem( title: "Stop", style:  UIBarButtonItemStyle.Plain, target: self, action: "stop" )
        self.navigationItem.rightBarButtonItem = stopButton
        
        albums = songQuery.get()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate
    func numberOfSectionsInTableView( tableView: UITableView ) -> Int {
        
        return albums.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Num: \(indexPath.row)")
        let musicId: NSNumber = albums[indexPath.section].musics[indexPath.row].musicId
        let item: MPMediaItem = MusicQuery.getItem(musicId)

        let url: NSURL = item.valueForProperty(MPMediaItemPropertyAssetURL) as! NSURL
        
        audio = AVAudioPlayer(contentsOfURL: url, error: nil)
        audio.play()
        
        self.title = albums[indexPath.section].musics[indexPath.row].title
    }
    
    func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
         let cell: UITableViewCell = UITableViewCell( style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell" )
        
        cell.textLabel!.text = albums[indexPath.section].musics[indexPath.row].title as String
        cell.detailTextLabel?.text = albums[indexPath.section].musics[indexPath.row].artist as String
        
        return cell
    }
    
    func tableView( tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
        
        return albums[section].musics.count
    }
    
    func tableView( tableView: UITableView, titleForHeaderInSection section: Int ) -> String? {
        
        return albums[section].albumTitle as String
    }
    
    func stop() {
        
        if audio != nil {
            audio.stop()
        }
    }
}

