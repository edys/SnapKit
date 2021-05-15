//
//  Factory.Swift
//  PresentationLayer
//
//  Created by Rhys Walden on 13/05/21.
//

import Foundation
import FieryCrucible
import UIKit
import PresentationLayer

/// Di Factory for the app (not 100% if this will be neede as of yet)
public class Factory: DependencyFactory
{
    let presentationLayerFactory = PresentationLayer.Factory()
    
    func mainWindow(windowScene: UIWindowScene) -> UIWindow {
            return unshared(
                factory: {
                    let instance = UIWindow(windowScene: windowScene)
                    instance.backgroundColor = UIColor.white;
                    return instance
                },
                configure: { [unowned self] instance in
                    instance.rootViewController = UINavigationController(
                        rootViewController: self.presentationLayerFactory.rootViewController()
                    )
                }
            )
        }
}
