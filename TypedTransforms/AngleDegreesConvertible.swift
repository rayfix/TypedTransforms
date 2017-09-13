//
//  AngleDegreesConvertible.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/13/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

public protocol AngleDegreesConvertible {
  associatedtype Real: FloatingPoint
  init(radians: Real)
  init(degrees: Real)
  var radians: Real { get set }
  var degrees: Real { set get }
  static var radiansToDegrees: Real { get }
}

extension AngleDegreesConvertible {
  public init(degrees: Real) {
    let degreesToRadians = 1 / Self.radiansToDegrees
    self.init(radians: degrees * degreesToRadians)
  }
  public var degrees: Real {
    get {
      return radians * Self.radiansToDegrees
    }
    set(newDegrees) {
      let degreesToRadians = 1 / Self.radiansToDegrees
      radians = newDegrees * degreesToRadians
    }
  }
}
