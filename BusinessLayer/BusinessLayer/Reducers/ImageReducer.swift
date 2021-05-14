//
//  ImageReducer.swift
//  BusinessLayer
//
//  Created by Rhys Walden on 14/05/21.
//

import Foundation
import ReSwift
import DataLayer

/// a reducer that takes a ImageActionProtocol actions and reduces posts state
internal class ImageReducer: AppReducerProtocol
{
    /// The reduce method
    func reduce(action: Action, state: AppState) -> (updated:Bool,state:AppState) {
        
        guard let imageAction = action as? ImageActionProtocol else
        {
            /// of the correct action for this reduce, return withou changing state
            return (false,state)
        }
        
        var currentState = state;
        
        switch imageAction {
        
        case is LoadingImageAction:
            currentState.images.append(ImageState.loading)
            
        case is ErrorLoadingImageAction:
            currentState.images[currentState.images.count-1] = ImageState.error
            
        case let loaded as LoadedImageAction:
            let mappedValues = mapImage(dto: loaded.image)
            currentState.images[currentState.images.count-1] = ImageState.loaded(loadedState: mappedValues)
            
        default:
            return (false,state)
        }
        
        return (true, currentState)
    }

    // TODO extract mapping to it own testable class Map<t1,t2> : MapProtocol
    private func mapImage(dto: ImageDTO) -> LoadedImageState
    {
        return LoadedImageState(id: dto.id, author: dto.author, download_url: dto.download_url)
    }
}
