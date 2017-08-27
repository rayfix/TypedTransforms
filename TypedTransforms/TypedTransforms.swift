//
//  TypedTransforms.swift
//  TypedTransforms
//
//  Created by Ray Fix on 8/27/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

public final class TypedTransforms<Base> {
  public let base: Base
  public init(_ base: Base) {
    self.base = base
  }
}

public protocol TypedTransformAdditions {
  associatedtype Typed
  var typed: Typed { get }
}

public extension TypedTransformAdditions {
  var typed: TypedTransforms<Self> {
    return TypedTransforms(self)
  }
}
