//
//  ImageApiService.swift
//  DataLayer
//
//  Created by Rhys Walden on 14/05/21.
//

import Foundation
import Combine
import Alamofire

public class ImageApiService: ImageApiServiceProtocol
{
    private let imagelistURL = "https://picsum.photos/v2/list"
    
    private let numberGenerator:NumberGeneratorProtocol
    
    init(numberGenerator: NumberGeneratorProtocol) {
        self.numberGenerator = numberGenerator
    }
    
    
    /// Get and returns a random Image.
    public func GetRandomImage() -> AnyPublisher<ImageDTO, DataError> {
        
        // TODO extract get method to a API service portocol that is passed in to init
        return AF
            .request(imagelistURL, method: .get)
            .validate()
            .publishDecodable(type: [ImageDTO].self)
            .value()
            .map({ (images) -> ImageDTO in
                return images[self.numberGenerator.getNextInt(max: images.count)]
            })
            .mapError { (error) -> DataError in
                print ("\(error)")
                return DataError.somthingWhenWrong
            }
            .eraseToAnyPublisher()
    }
}
