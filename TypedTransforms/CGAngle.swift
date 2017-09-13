//
//  CGAngle.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/11/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

extension CGFloat: TrigonometricFloatingPoint {
  public func sin() -> CGFloat {
    return CoreGraphics.sin(self)
  }
  public func cos() -> CGFloat {
    return CoreGraphics.cos(self)
  }
}

public struct CGAngle: AngleProtocol {
  public var radians: CGFloat
  public init(radians: CGFloat) {
    self.radians = radians
  }
}

extension CGAngle: AngleDegreesConvertible {
  public static var radiansToDegrees: CGFloat {
    return 180/CGFloat.pi
  }
}
