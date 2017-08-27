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
}
