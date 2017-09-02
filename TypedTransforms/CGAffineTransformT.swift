//
//  CGAffineTransformT.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/2/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation


public struct CGAffineTransformT<From: CoordinateSpace, To: CoordinateSpace> {
  var matrix: CGAffineTransform
  init(_ matrix: CGAffineTransform) {
    self.matrix = matrix
  }

  public static func *<From,To>(point: CGPointT<From>, transform: CGAffineTransformT<From,To>) -> CGPointT<To> {
    return CGPointT<To>(point.xy.applying(transform.matrix))
  }

  public static func * <From,Intermediate,To>(from: CGAffineTransformT<From, Intermediate>,
                                to: CGAffineTransformT<Intermediate, To>) -> CGAffineTransformT<From, To> {
    return CGAffineTransformT<From, To>(from.matrix.concatenating(to.matrix))
  }
}



