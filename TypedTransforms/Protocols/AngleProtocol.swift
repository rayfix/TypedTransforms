//
//  AngleProtocol.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/13/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

public protocol TrigonometricFloatingPoint: FloatingPoint {
  static func sine(radians: Self) -> Self
  static func cosine(radians: Self) -> Self
  static func arctan2(y: Self, x: Self) -> Self
}

public protocol AngleProtocol: Hashable, Comparable {
  associatedtype Real: TrigonometricFloatingPoint
  init(radians: Real)
  init(x: Real, y: Real)
  var radians: Real { set get }
}

public extension AngleProtocol {

  func normalized() -> Self {
    return Self(radians: Real.arctan2(y: Real.sine(radians: self.radians),
                                      x: Real.cosine(radians: self.radians)))
  }

  static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.radians == rhs.radians
  }

  var hashValue: Int {
    return radians.hashValue
  }

  static func <(lhs: Self, rhs: Self) -> Bool {
    return lhs.radians < rhs.radians
  }

  init(x: Real, y: Real) {
    self.init(radians: Real.arctan2(y: y, x: x))
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

  static var zero: Self {
    return Self(radians: 0)
  }

  static var pi: Self {
    return Self(radians: Real.pi)
  }

  static var twoPi: Self {
    return Self(radians: 2*Real.pi)
  }

  static var piOverTwo: Self {
    return Self(radians: Real.pi/2)
  }

}

public func sin<A: AngleProtocol>(_ angle: A) -> A.Real {
  return A.Real.sine(radians: angle.radians)
}

public func cos<A: AngleProtocol>(_ angle: A) -> A.Real {
  return A.Real.cosine(radians: angle.radians)
}




