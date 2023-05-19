//
//  TestHandler.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 16.05.2023.
//

struct TestHandler: Identifiable {
    
    let id: Int
    let title: String
}

protocol TestStore {
    
    var tests: [TestHandler] { get }
    
    var testId: Int { get set }
    
}
