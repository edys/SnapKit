//
//  UIView.swift
//  PresentationLayer
//
//  Created by Rhys Walden on 15/05/21.
//

import Foundation
import UIKit

public extension UIView{
    func addTo(_ parent:UIView) -> Self{
        parent.addSubview(self)
        return self
    }
}
