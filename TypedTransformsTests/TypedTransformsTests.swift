//
//  TypedTransformsTests.swift
//  TypedTransformsTests
//
//  Created by Ray Fix on 8/27/17.
//  Copyright © 2017 Ray Fix. All rights reserved.
//

import XCTest
import TypedTransforms

class Foo {}

extension Foo: TypedTransformAdditions {}
extension TypedTransforms where Base: Foo {
  func compute() -> Int {
    return 42
  }
}

class TypedTransformsTests: XCTestCase {
    
  func testMethodAddition() {
    let answer = Foo().typed.compute()
    XCTAssertEqual(answer, 42)
  }
}

class CGPointTTest: XCTestCase {
  func testCGPointInit() {
    let p = CGPoint(21, 42)
    let tp: CGPointT<ModelSpace> = p.typed()
    XCTAssertEqual(tp.xy, p)

    let tp2 = CGPointT<ModelSpace>(21, 42)
    XCTAssertEqual(tp, tp2)
  }

  func testCGPointSetGet() {
    var p = CGPointT<WorldSpace>(3, 1)
    XCTAssertEqual(p.x, 3)
    XCTAssertEqual(p.y, 1)
    p.x = 4
    p.y = 3
    XCTAssertEqual(p.x, 4)
    XCTAssertEqual(p.y, 3)
  }

  func testCGPointAdd() {
    var point = CGPointT<WorldSpace>(30,40)
    let offset = CGPointT<WorldSpace>(10,20)
    point = point + offset
    XCTAssertEqual(point.x, 40)
    XCTAssertEqual(point.y, 60)
  }

  func testCGPointPostMultiply() {
    let point = CGPoint(1,2) * 3
    XCTAssertEqual(point.x, 3)
    XCTAssertEqual(point.y, 6)
  }

  func testCGPointPreMultiply() {
    let point = 3 * CGPoint(1,2)
    XCTAssertEqual(point.x, 3)
    XCTAssertEqual(point.y, 6)
  }

  func testCGPointNegate() {
    let point = -CGPoint(1,2)
    XCTAssertEqual(point.x, -1)
    XCTAssertEqual(point.y, -2)
  }

  func testCGPointSubtract() {
    let point = CGPoint(1,2) - CGPoint(10,20)
    XCTAssertEqual(point.x, -9)
    XCTAssertEqual(point.y, -18)
  }

  func testCGPointLength() {
    let point = CGPoint(1,2)
    XCTAssertEqual(point.lengthSquared, 5)
    XCTAssertEqual(point.length, sqrt(5))
  }

  func testCGPointUnit() {
    let point = CGPoint(100,120).unit
    XCTAssertNotEqual(point.x, point.y)
    XCTAssertEqual(point.length, 1)
  }

  func testTransformPoint() {
    let point: CGPointT<WorldSpace> = CGPoint(1,2).typed()
    let transform = CGAffineTransformT<WorldSpace,CameraSpace>(CGAffineTransform(scaleX: 2, y: 3))
    let cameraPoint = point * transform
    XCTAssertEqual(cameraPoint.x, 2)
    XCTAssertEqual(cameraPoint.y, 6)
  }
}

class CGAffineTransformTTest: XCTestCase {
  func testCGTransformInverse() {
    let worldToCamera = CGAffineTransformT<WorldSpace,CameraSpace>(CGAffineTransform(scaleX: 2, y: 3))
    let cameraToWorld = worldToCamera.inverted()
    let identity = worldToCamera * cameraToWorld
    XCTAssertEqual(identity.matrix.a, 1 )
    XCTAssertEqual(identity.matrix.b, 0 )
    XCTAssertEqual(identity.matrix.c, 0 )
    XCTAssertEqual(identity.matrix.d, 1 )
    XCTAssertEqual(identity.matrix.tx, 0 )
    XCTAssertEqual(identity.matrix.ty, 0 )
  }
}
