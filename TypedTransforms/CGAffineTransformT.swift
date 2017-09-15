//
//  CGAffineTransformT.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/2/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import CoreGraphics

extension CGAffineTransform {
  static func *(point: CGPoint, transform: CGAffineTransform) -> CGPoint {
    return point.applying(transform)
  }

  static func *(lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
    return lhs.concatenating(rhs)
  }
}

public struct CGAffineTransformT<From: CoordinateSpace, To: CoordinateSpace> {
  public var matrix: CGAffineTransform
  public init(_ matrix: CGAffineTransform) {
    self.matrix = matrix
  }
  public func inverted() -> CGAffineTransformT<To,From> {
    return CGAffineTransformT<To,From>(matrix.inverted())
  }
}

public func *<From,To>(point: CGPointT<From>, transform: CGAffineTransformT<From,To>) -> CGPointT<To> {
  return CGPointT<To>(point.xy.applying(transform.matrix))
}

public func * <From,To,I>(from: CGAffineTransformT<From, I>,
                          to: CGAffineTransformT<I, To>) -> CGAffineTransformT<From, To> {
  return CGAffineTransformT<From, To>(from.matrix.concatenating(to.matrix))
}


