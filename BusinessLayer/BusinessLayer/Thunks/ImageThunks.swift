//
//  ImageThunks.swift
//  BusinessLayer
//
//  Created by Rhys Walden on 14/05/21.
//

import Foundation
import ReSwift
import DataLayer
import ReSwiftThunk
import Combine

// the middle ware Thunk for loading a image and adding it to the state
public class RefreshImageThunk
{
    let imageApiService: ImageApiServiceProtocol
    
    init (imageApiService: ImageApiServiceProtocol)
    {
        self.imageApiService = imageApiService
    }
    
    var cancellable:AnyCancellable?
    
    public func action() -> Thunk<AppState> {
        return Thunk<AppState> { [unowned self] dispatch, getState in
            
            // thunk is allready running, dont repeat actions
            if self.cancellable != nil {
                
                return
            }
            
            dispatch(LoadingImageAction())
            
            self.cancellable =
                self.imageApiService
                    .GetRandomImage()
                    .sink(receiveCompletion: { [unowned self] (finished) in
                        
                        self.cancellable = nil
                        
                        if case .failure(_) = finished {
                            dispatch(ErrorLoadingImageAction())
                        }
                        
                    }) { (image) in
                        
                        // TODO add duplicate check
                         dispatch(LoadedImageAction(image: image)
                    )
            }
        }
    }
}
