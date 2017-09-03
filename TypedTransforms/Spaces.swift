//
//  Spaces.swift
//  TypedTransforms
//
//  Created by Ray Fix on 8/27/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import Foundation

public protocol CoordinateSpace {}

// Some common coordinate spaces
public enum ModelSpace: CoordinateSpace {}
public enum WorldSpace: CoordinateSpace {}
public enum CameraSpace: CoordinateSpace {}
public enum ClientSpace: CoordinateSpace {}
