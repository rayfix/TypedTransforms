//
//  ARCamera+TypedTransforms.swift
//  TypedTransforms
//
//  Created by Ray Fix on 9/15/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import ARKit

extension ARCamera: TypedTransformAdditions {}

public
extension TypedTransforms where Base: ARCamera {
  public var cameraFromWorld: matrix_float4x4_t<CameraSpace, WorldSpace> {
    return matrix_float4x4_t(base.transform).inverted()
  }
  public var worldFromCamera: matrix_float4x4_t<WorldSpace, CameraSpace> {
    return matrix_float4x4_t(base.transform)
  }
}
