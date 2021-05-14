//
//  ImageAPIServiceProtocol.swift
//  DataLayer
//
//  Created by Rhys Walden on 14/05/21.
//

import Foundation
import Combine

/// Service for getting images
public protocol ImageApiServiceProtocol
{
    /// Get and returns a random Image.
    func GetRandomImage() -> AnyPublisher<ImageDTO,DataError>
}
