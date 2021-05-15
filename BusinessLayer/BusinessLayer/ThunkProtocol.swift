//
//  ThunkProtocol.swift
//  BusinessLayer
//
//  Created by Rhys Walden on 16/05/21.
//

import Foundation
import ReSwift
import ReSwiftThunk

/// thunk protocol
public protocol ThunkProtocol
{
    /// thunk action to update the state in async manner
    func action() -> Thunk<AppState>
}
