//
//  Factory.Swift
//  PresentationLayer
//
//  Created by Rhys Walden on 13/05/21.
//

import Foundation
import FieryCrucible
import ReSwift
import ReSwiftThunk
import DataLayer

/// Di Factory for the business layer
public class Factory: DependencyFactory
{
    let dataLayerFactory = DataLayer.Factory()
    
    
    /// Creates a singleton appsStore
    public func appStore() -> Store<AppState> {
        return shared (factory: { () -> Store<AppState> in
            return generateAppStore()
        })
    }
    
    public func loadImageThunk() -> ThunkProtocol{
        return shared(LoadImageThunk(imageApiService: dataLayerFactory.imageApiServiceProtocol()))
    }

    
    /// Create a singleton  reducer for reducing ImageState
    private func imageReducer() -> AppReducerProtocol {
       return shared(ImageReducer())
    }
    
    /// helper method for crating an appstore instance - TODO extract to protocol and class
    private func generateAppStore() -> Store<AppState> {
        
        let reducers : [AppReducerProtocol] = [
            
            imageReducer()
        ]
        
        let thunkMiddleware: Middleware<AppState> =  createThunkMiddleware()
        
        let appStore = Store<AppState>(reducer: { (action, appState) -> AppState in
            var currentAppState = appState ?? AppState()
            for reducer in reducers
            {
                let result = reducer.reduce(action: action, state: currentAppState)
                if (result.updated)
                {
                    currentAppState = result.state
                    break
                }
            }
            return currentAppState;
        }, state: nil, middleware: [thunkMiddleware])
        
        return appStore
    }
}
