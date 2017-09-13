//
//  CGAngle.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/11/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

extension CGFloat: TrigonometricFloatingPoint {
  public static func sine(radians: CGFloat) -> CGFloat {
    return sin(radians)
  }
  public static func cosine(radians: CGFloat) -> CGFloat {
    return cos(radians)
  }
  public static func arctan2(y: CGFloat, x: CGFloat) -> CGFloat {
    return atan2(y, x)
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
