//
//  File.swift
//  BusinessLayer
//
//  Created by Rhys Walden on 14/05/21.
//

import Foundation

// Image State
public enum ImageState
{
    case loading
    
    case error
    
    case loaded(loadedState: LoadedImageState)
}

/// Associated Data for the loaded image state
public struct LoadedImageState {
    
    /// Id
    public let id: Int
    
    /// author
    public let author:String
    
    /// download_url
    public let download_url:String
}


