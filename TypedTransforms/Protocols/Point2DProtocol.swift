//
//  Point2DProtocol.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/14/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

public protocol Point2DProtocol: Equatable {
  associatedtype Scalar: FloatingPoint
  init(_ x: Scalar, _ y: Scalar)
  var x: Scalar { get set }
  var y: Scalar { get set }
}

public extension Point2DProtocol {
  var lengthSquared: Scalar {
    return self*self
  }
  var length: Scalar {
    return lengthSquared.squareRoot()
  }
  var unit: Self {
    return self * (1/length)
  }
  var orthogonal: Self {
    return Self(-y,x)
  }
  func projected(on other: Self) -> Self {
    return ((self*other)/(other*other))*other
  }
  static func +(lhs: Self, rhs: Self) -> Self {
    return Self(lhs.x + rhs.x, lhs.y + rhs.y)
  }
  static prefix func -(p: Self) -> Self {
    return Self(-p.x, -p.y)
  }
  static func -(lhs: Self, rhs: Self) -> Self {
    return lhs+(-rhs)
  }
  static func *(scalar: Scalar, point: Self) -> Self {
    return Self(scalar*point.x, scalar*point.y)
  }
  static func *(point: Self, scalar: Scalar) -> Self {
    return scalar*point
  }
  static func *(lhs: Self, rhs: Self) -> Scalar {
    return lhs.x*rhs.x+lhs.y*rhs.y
  }
  static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }
}
