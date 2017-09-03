//
//  CGPointT.swift
//  TypedTransforms
//
//  Created by Ray Fix on 8/27/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

public protocol PointProtocol2D: Equatable {
  associatedtype Scalar: FloatingPoint
  init(_ x: Scalar, _ y: Scalar)
  var x: Scalar { get set }
  var y: Scalar { get set }
  var lengthSquared: Scalar { get }
  var length: Scalar { get }
  var unit: Self { get }
}

public extension PointProtocol2D {
  var lengthSquared: Scalar {
    return x*x + y*y
  }
  var length: Scalar {
    return lengthSquared.squareRoot()
  }
  var unit: Self {
    return self * (1/length)
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
  static func ==(lhs: Self, rhs: Self) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }
}

public struct CGPointT<Space: CoordinateSpace>: PointProtocol2D {

  public typealias Scalar = CGFloat
  public var xy: CGPoint
  public init(_ xy: CGPoint) {
    self.xy = xy
  }

  public init(_ x: CGFloat, _ y: CGFloat) {
    xy = CGPoint(x: x, y: y)
  }

  public var x: CGFloat {
    get {
      return xy.x
    }
    set {
      xy.x = newValue
    }
  }

  public var y: CGFloat {
    get {
      return xy.y
    }
    set {
      xy.y = newValue
    }
  }
}

extension CGPoint: PointProtocol2D {
  public init(_ x: CGFloat, _ y: CGFloat) {
    self.x = x
    self.y = y
  }
}

public extension CGPoint {
  func typed<Space>() -> CGPointT<Space>  {
    return CGPointT<Space>(self)
  }
}
