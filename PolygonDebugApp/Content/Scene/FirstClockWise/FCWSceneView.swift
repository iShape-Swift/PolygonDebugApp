//
//  FCWSceneView.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 18.06.2023.
//

import SwiftUI

struct FCWSceneView: View {
 
    @ObservedObject
    var scene: FCWScene
    
    var body: some View {
        return HStack {
            GeometryReader { proxy in
                content(size: proxy.size)
            }
        }
    }
    
    private func content(size: CGSize) -> some View {
        scene.initSize(screenSize: size)
        return ZStack {
            Color.white
            scene.dotsEditorView()
            ForEach(scene.edges) { edge in
                Path() { path in
                    path.move(to: edge.p0)
                    path.addLine(to: edge.p1)
                }.stroke(style: .init(lineWidth: 4, lineCap: .round)).foregroundColor(edge.color)
            }
            
        }.onAppear() {
            scene.onAppear()
        }
    }

}
