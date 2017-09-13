//
//  AngleProtocol.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/13/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

public protocol TrigonometricFloatingPoint: FloatingPoint {
  func sin() -> Self
  func cos() -> Self
  // Add more here...
}

public protocol AngleProtocol: Hashable, Comparable {
  associatedtype Real: TrigonometricFloatingPoint
  init(radians: Real)
  var radians: Real { set get }
}

public extension AngleProtocol {
  static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.radians == rhs.radians
  }

  var hashValue: Int {
    return radians.hashValue
  }

  static func <(lhs: Self, rhs: Self) -> Bool {
    return lhs.radians < rhs.radians
  }

  static func +(lhs: Self, rhs: Self) -> Self {
    return Self(radians: lhs.radians + rhs.radians)
  }

  static prefix func -(angle: Self) -> Self {
    return Self(radians: -angle.radians)
  }

  static func -(lhs: Self, rhs: Self) -> Self {
    return lhs+(-rhs)
  }

  static func *(multiple: Real, angle: Self) -> Self {
    return Self(radians: multiple*angle.radians)
  }

  static func *(angle: Self, multiple: Real) -> Self {
    return multiple*angle
  }

  static func /(angle: Self, divisor: Real) -> Self {
    return angle * (1/divisor)
  }

  static func +=(lhs: inout Self, rhs: Self) {
    lhs = lhs + rhs
  }

  static func -=(lhs: inout Self, rhs: Self) {
    lhs = lhs - rhs
  }

  static func *=(lhs: inout Self, rhs: Real) {
    lhs = lhs * rhs
  }

  static func /=(lhs: inout Self, rhs: Real) {
    lhs = lhs / rhs
  }

  static var pi: Self {
    return Self(radians: Real.pi)
  }
}

public func sin<A: AngleProtocol>(_ angle: A) -> A.Real {
  return angle.radians.sin()
}

public func cos<A: AngleProtocol>(_ angle: A) -> A.Real {
  return angle.radians.cos()
}




