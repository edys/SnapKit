//
//  ImageAction.swift
//  BusinessLayer
//
//  Created by Rhys Walden on 14/05/21.
//

import Foundation
import ReSwift
import DataLayer


/// protocol for image actions
public protocol ImageActionProtocol : Action {}

/// Action to for loading image
public struct LoadingImageAction: ImageActionProtocol {}

/// Action for Loaded image
public struct LoadedImageAction: ImageActionProtocol
{
    let image: ImageDTO
}
/// Action for signaling an error has occured while loading images
public struct ErrorLoadingImageAction: ImageActionProtocol {}
