//
//  AppReducer.swift
//  BusinessLayer
//
//  Created by Rhys Walden on 14/05/21.
//

import Foundation
import ReSwift

/// Reduce the appstate based on actions
internal protocol AppReducerProtocol
{
    /// Reduce the appstate
    /// - Parameters:
    ///   - action: an action to trigger a reduction of state
    ///   - state: current state
    func reduce(action:Action, state:AppState) -> (updated:Bool,state:AppState)
}
