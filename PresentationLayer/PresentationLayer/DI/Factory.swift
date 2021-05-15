//
//  Factory.Swift
//  PresentationLayer
//
//  Created by Rhys Walden on 13/05/21.
//

import Foundation
import FieryCrucible
import BusinessLayer

/// Di Factory for the presentation layer
public class Factory: DependencyFactory
{
    let businessLayerFactory = BusinessLayer.Factory()
    
    public func rootViewController() -> RootViewController {
        return unshared(
            RootViewController(
                appStore: businessLayerFactory.appStore(),
                loadImageThunk: businessLayerFactory.loadImageThunk(),
                imageCache: imageCache()
            )
        )
    }
    
    private func imageCache() -> ImageCacheProtocol{
        return shared(ImageCache())
    }
}
