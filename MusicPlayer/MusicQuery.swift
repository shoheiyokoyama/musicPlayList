//
//  MusicQuery.swift
//  MusicPlayer
//
//  Created by Shohei Yokoyama on 2015/08/03.
//  Copyright (c) 2015年 Shohei. All rights reserved.
//

import UIKit
//import Foundation
import MediaPlayer

struct MusicInfo {
    var albumTitle: NSString
    var artist: NSString
    var title: NSString
    var musicId: NSNumber
}

struct AlbumInfo {
    var albumTitle: NSString
    var musics: [MusicInfo]
}

class MusicQuery {
   
    func get() -> [AlbumInfo] {
        
        var albums: [AlbumInfo] = []
        
        var albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
        var albmsItems: NSArray = albumsQuery.collections
        var album: MPMediaItemCollection
        
        for album in albmsItems {
            var albumItems: [MPMediaItem] = album.items as! [MPMediaItem]
            var music: MPMediaItem = MPMediaItem()
            var musics: [MusicInfo] = []
            var albumTitle: NSString = ""
            
            for song in albumItems {
                
                albumTitle = music.valueForProperty( MPMediaItemPropertyAlbumTitle ) as! NSString
                
                var musicInfo: MusicInfo = MusicInfo(
                    albumTitle: music.valueForProperty( MPMediaItemPropertyAlbumTitle ) as! NSString,
                    artist: music.valueForProperty( MPMediaItemPropertyArtist ) as! NSString,
                    title: music.valueForProperty( MPMediaItemPropertyTitle ) as! NSString,
                    musicId: music.valueForProperty( MPMediaItemPropertyPersistentID ) as! NSNumber
                )
                
                musics.append(musicInfo)
            }
            
            var albumInfo: AlbumInfo = AlbumInfo(
                albumTitle: albumTitle,
                musics: musics
            )
            
            albums.append(albumInfo)
        }
        
        return albums
    }
    
    func getItem( songId: NSNumber ) -> MPMediaItem {
        
        var property: MPMediaPropertyPredicate = MPMediaPropertyPredicate( value: songId, forProperty: MPMediaItemPropertyPersistentID )
        
        var query: MPMediaQuery = MPMediaQuery()
        query.addFilterPredicate(property)
        
        var items: [MPMediaItem] = query.items as! [MPMediaItem]
        
        return items[items.count - 1]
        
    }
    
}
