//
//  PolygonData.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

import CoreGraphics
import iPolygon

struct SimplePolygonTest {
    let name: String
    let pA: PolygonData
    let pB: PolygonData
}


struct PolygonData {
    
    let isConvex: Bool
    let points: [CGPoint]
    
}

struct AreaTest {
    let name: String
    let p0: CGPoint
    let p1: CGPoint
    let path: [CGPoint]
}

struct ShapeTest {
    let name: String
    let shape: CGShape
}

struct FCWTest {
    let name: String
    let center: CGPoint
    let p0: CGPoint
    let p1: CGPoint
    let p2: CGPoint
}
