//
//  ShapeRelatedView.swift
//  swiftuidemo
//
//  Created by 陳峻琦 on 18/1/2022.
//

import SwiftUI

struct ShapeRelatedView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
                    Rectangle()
                        .frame(width: 100, height: 100)
                    
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .frame(width: 100, height: 100)
                    
                    Circle()
                        .frame(width: 100, height: 100)
                    
                    Capsule()
                        .frame(width: 100, height: 50)
                    
                    Ellipse()
                        .frame(width: 100, height: 50)
                }
                .foregroundColor(.yellow)
    }
}

struct ShapeRelatedView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeRelatedView()
    }
}
