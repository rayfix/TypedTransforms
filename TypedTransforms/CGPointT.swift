//
//  CGPointT.swift
//  TypedTransforms
//
//  Created by Ray Fix on 8/27/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import CoreGraphics

public struct CGPointT<Space: CoordinateSpace>: Point2DProtocol {

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

extension CGPoint: Point2DProtocol {
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
