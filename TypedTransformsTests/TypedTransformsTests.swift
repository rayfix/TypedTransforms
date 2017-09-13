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

  func testCGPointOrthogonal() {
    let point = CGPointT<CameraSpace>(1,2)
    let dot = point * point.orthogonal
    XCTAssertEqual(dot, 0)
  }

  func testTransformPoint() {
    let point: CGPointT<WorldSpace> = CGPoint(1,2).typed()
    let transform = CGAffineTransformT<WorldSpace,CameraSpace>(CGAffineTransform(scaleX: 2, y: 3))
    let cameraPoint = point * transform
    XCTAssertEqual(cameraPoint.x, 2)
    XCTAssertEqual(cameraPoint.y, 6)
  }

  func testProjection() {
    let point = CGPoint(2,3)
    let line = CGPoint(1,2)
    let projectedPoint = point.projected(on: line)
    XCTAssertEqual(projectedPoint.x, 8.0/5.0)
    XCTAssertEqual(projectedPoint.y, 16.0/5.0)
  }
}

class CGAngleTests: XCTestCase {

  let eps: CGFloat = 1e-9

  func testAngleInit() {
    var angle = CGAngle(radians: 123)
    XCTAssertEqual(angle.radians, 123)
    angle.radians = 456
    XCTAssertEqual(angle.radians, 456)
  }

  func testEquality() {
    let angle1 = CGAngle(radians: 123)
    let angle2 = CGAngle(radians: 456)
    let angle3 = CGAngle(radians: 123)

    XCTAssertEqual(angle1, angle1)
    XCTAssertNotEqual(angle1, angle2)
    XCTAssertEqual(angle1, angle3)
  }

  func testComparison() {
    let angle1 = CGAngle(radians: 123)
    let angle2 = CGAngle(radians: 124)
    XCTAssertGreaterThan(angle2, angle1)
  }

  func testAdd() {
    let angle = CGAngle(radians: 1) + CGAngle(radians: 2)
    XCTAssertEqual(angle, CGAngle(radians: 3))
  }

  func testNegate() {
    let angle = -CGAngle(radians: 1)
    XCTAssertEqual(angle, CGAngle(radians: -1))
  }

  func testSubtract() {
    let angle = CGAngle(radians: 3) - CGAngle(radians: 1)
    XCTAssertEqual(angle, CGAngle(radians: 2))
  }

  func testAccumulate() {
    var angle = CGAngle(radians: 1)
    angle += CGAngle(radians: 2)
    XCTAssertEqual(angle, CGAngle(radians: 3))
  }

  func testMinusAccumulate() {
    var angle = CGAngle(radians: 1)
    angle -= CGAngle(radians: 2)
    XCTAssertEqual(angle, CGAngle(radians: -1))
  }

  func testPostMultiplyScalar() {
    let angle = CGAngle(radians: 1)
    XCTAssertEqual(angle*3, CGAngle(radians: 3))
  }

  func testPreMultiplyScalar() {
    let angle = CGAngle(radians: 1)
    XCTAssertEqual(3*angle, CGAngle(radians: 3))
  }

  func testMultiplyAccumulate() {
    var angle = CGAngle(radians: 1)
    angle *= 3
    XCTAssertEqual(3*angle, CGAngle(radians: 9))
  }

  func testDivide() {
    let angle = CGAngle(radians: 10)
    XCTAssertEqual(angle/2, CGAngle(radians: 5))
  }

  func testDivideAccumulate() {
    var angle = CGAngle(radians: 10)
    angle /= 2
    XCTAssertEqual(angle, CGAngle(radians: 5))
  }

  func testSinCos() {
    XCTAssertEqual(sin(CGAngle(radians: 0)), 0)
    XCTAssertEqual(cos(CGAngle(radians: 0)), 1)
    XCTAssertEqual(cos(CGAngle.pi),  -1, accuracy: eps)
    XCTAssertEqual(sin(CGAngle.pi),  0, accuracy: eps)
    XCTAssertEqual(cos(CGAngle.pi/2),  0, accuracy: eps)
    XCTAssertEqual(sin(CGAngle.pi/2),  1, accuracy: eps)
  }

  func testDegreesInit() {
    let angle = CGAngle(degrees: 90)
    XCTAssertEqual(angle.degrees, 90)
    XCTAssertEqual(angle, CGAngle.pi/2)
  }

  func testDegreesSetter() {
    var angle = CGAngle(degrees: 0)
    angle.degrees = 90
    XCTAssertEqual(angle.degrees, 90)
    XCTAssertEqual(angle, CGAngle.pi/2)
  }

  func testHashValue() {
    let angleSet: Set<CGAngle> = [CGAngle.pi/2, CGAngle.pi, CGAngle(radians: 0), CGAngle.pi]
    XCTAssertEqual(angleSet.count, 3)
  }

  func testNormalized() {
    let base: CGFloat = 23
    let angle1 = CGAngle(degrees: base)
    let angle2 = CGAngle(degrees: 360*3 + base)
    let angle3 = CGAngle(degrees: -360*10 + base)

    XCTAssertNotEqual(angle1, angle2)
    XCTAssertNotEqual(angle1, angle3)
    XCTAssertNotEqual(angle2, angle3)

    XCTAssertEqual(angle1.normalized().radians, angle2.normalized().radians, accuracy: eps)
    XCTAssertEqual(angle1.normalized().radians, angle3.normalized().radians, accuracy: eps)
    XCTAssertEqual(angle2.normalized().radians, angle3.normalized().radians, accuracy: eps)
  }

  func testVectorInit1() {

    let vector: [(CGFloat, CGFloat, CGFloat)] = [(10,0,0),
                                                 (10,10,45),
                                                 (0,10,90),
                                                 (-10,10,135),
                                                 (-10,0,180),
                                                 (-10,-10,-135),
                                                 (0,-10,-90),
                                                 (10,-10,-45),
                                                 (0,0,0)]
    for item in vector {
      let angle = CGAngle(x: item.0, y: item.1)
      XCTAssertEqual(angle.degrees, CGAngle(degrees: item.2).degrees, accuracy: eps)
    }
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
