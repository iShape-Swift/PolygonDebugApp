//
//  AreaSceneView.swift
//  PolygonDebugApp
//
//  Created by Nail Sharipov on 18.05.2023.
//

import SwiftUI

struct AreaSceneView: View {
 
    @ObservedObject
    var scene: AreaScene
    
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
            if !scene.polygon.isEmpty {
                Path { path in
                    path.addLines(scene.polygon)
                    path.closeSubpath()
                }.fill().foregroundColor(scene.areaColor)
            }

            if let p0 = scene.start, let p1 = scene.end {
                Path { path in
                    path.move(to: p0)
                    path.addLine(to: p1)
                }.stroke(style: .init(lineWidth: 4, lineCap: .round)).foregroundColor(.orange)
            }
            
            if let areaPos = scene.areaPos {
                Text(scene.area)
                    .position(areaPos).font(.title2).foregroundColor(.black)
            }
        }.onAppear() {
            scene.onAppear()
        }
    }

}
