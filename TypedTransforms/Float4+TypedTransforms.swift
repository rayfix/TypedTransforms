//
//  Float4+TypedTransforms.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/15/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import ARKit

public struct matrix_float4x4_t<To: CoordinateSpace, From: CoordinateSpace> {
  public var matrix: matrix_float4x4
  public init(_ matrix: matrix_float4x4) {
    self.matrix = matrix
  }
}

public struct float4_t<Space: CoordinateSpace> {
  public var point: float4
  init(_ point: float4) {
    self.point = point
  }
}

extension matrix_float4x4_t {


  public func inverted() -> matrix_float4x4_t<From, To> {
    return matrix_float4x4_t<From, To>(matrix.inverse)
  }
}

public func *<To, From>(lhs: matrix_float4x4_t<To, From>, rhs: float4_t<From>) -> float4_t<To> {
  return float4_t<To>(lhs.matrix * rhs.point)
}
