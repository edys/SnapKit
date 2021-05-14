//
//  ImageDTO.swift
//  DataLayer
//
//  Created by Rhys Walden on 14/05/21.
//

import Foundation

/*
     {
         "id": "0",
         "author": "Alejandro Escamilla",
         "width": 5616,
         "height": 3744,
         "url": "https://unsplash.com/...",
         "download_url": "https://picsum.photos/..."
     }
 
 */

public struct ImageDTO: Codable{
    
    /// Id
    public let id: Int
    
    /// author
    public let author:String
    
    /// download_url
    public let download_url:String
}
