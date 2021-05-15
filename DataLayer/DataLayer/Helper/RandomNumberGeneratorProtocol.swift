//
//  RandomNumberGeneratorProtocol.swift
//  DataLayer
//
//  Created by Rhys Walden on 16/05/21.
//

import Foundation

public protocol NumberGeneratorProtocol{
    func getNextInt(max:Int) -> Int
}

public class RandomNumberGenerator: NumberGeneratorProtocol{
    public func getNextInt(max: Int) -> Int {
        return Int.random(in: 0..<max)
    }
}
