//
//  PinDot.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 17.05.2023.
//

import SwiftUI
import iDebug

struct PinDot: Identifiable {
    
    public let id: Int
    public let center: CGPoint
    public let color: Color
    public let title: String?
    
}


struct PinDotView: View {
    
    let dot: PinDot
    
    var body: some View {
        let r: CGFloat = 4
        return ZStack() {
            Circle()
                .size(width: 2 * r, height: 2 * r)
                .offset(dot.center - CGPoint(x: r, y: r))
                .foregroundColor(dot.color)
            
            if let title = dot.title {
                Text(title).position(dot.center + CGPoint(x: -2, y: -10)).foregroundColor(.red)
            }
        }
    }
}
