//
//  Factory.Swift
//  DataLayer
//
//  Created by Rhys Walden on 13/05/21.
//

import Foundation
import FieryCrucible

/// Di Factory for the data layer
public class Factory: DependencyFactory
{
    public func imageApiServiceProtocol() -> ImageApiServiceProtocol {
        return shared(ImageApiService(numberGenerator: randomNumberGenerator()))
    }
    
    public func randomNumberGenerator() -> NumberGeneratorProtocol {
        return shared(RandomNumberGenerator())
    }
}
