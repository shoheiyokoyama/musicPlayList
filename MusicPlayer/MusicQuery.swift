//
//  MusicQuery.swift
//  MusicPlayer
//
//  Created by Shohei Yokoyama on 2015/08/03.
//  Copyright (c) 2015年 Shohei. All rights reserved.
//

import UIKit
import MediaPlayer

struct MusicInfo {
    var albumTitle: String
    var artist: String
    var title: String
    var musicId: NSNumber
}

struct AlbumInfo {
    var albumTitle: String
    var musics: [MusicInfo]
}

class MusicQuery {
   
    func get() -> [AlbumInfo] {
        
        var albums: [AlbumInfo] = []
        
        var albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
        var albumItems: [MPMediaItemCollection] = albumsQuery.collections as! [MPMediaItemCollection]
        var album: MPMediaItemCollection
        
        for album in albumItems {
            var albumItems: [MPMediaItem] = album.items as! [MPMediaItem]
            var music: MPMediaItem = MPMediaItem()
            var musics: [MusicInfo] = []
            var albumTitle: NSString = ""
            
            for music in albumItems {
                albumTitle = music.valueForProperty( MPMediaItemPropertyAlbumTitle ) as! String

                var musicInfo: MusicInfo = MusicInfo(
                    albumTitle: music.valueForProperty( MPMediaItemPropertyAlbumTitle ) as! String,
                    artist: music.valueForProperty( MPMediaItemPropertyArtist ) as! String,
                    title: music.valueForProperty( MPMediaItemPropertyTitle ) as! String,
                    musicId: music.valueForProperty( MPMediaItemPropertyPersistentID ) as! NSNumber
                )
                musics.append(musicInfo)
            }
            
            var albumInfo: AlbumInfo = AlbumInfo(
                albumTitle: albumTitle as String,
                musics: musics
            )
            albums.append(albumInfo)
        }
        
        return albums
    }
    
    func getItem(songId: NSNumber) -> MPMediaItem {
        var property: MPMediaPropertyPredicate = MPMediaPropertyPredicate(value: songId, forProperty: MPMediaItemPropertyPersistentID)
        
        var query: MPMediaQuery = MPMediaQuery()
        query.addFilterPredicate(property)
        
        var items: [MPMediaItem] = query.items as! [MPMediaItem]
        
        return items[items.count - 1]
        
    }
    
}
