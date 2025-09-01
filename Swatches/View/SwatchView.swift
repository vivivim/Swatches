//
//  SwatchView.swift
//  Swatches
//
//  Created by Admin on 8/27/25.
//

import SwiftUI

struct SwatchView: View {
    let swatch: Swatch
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(swatch.title)
                .font(.title)
            Text("실: " + swatch.yarn)
            Text("바늘: " + swatch.needle + " mm")
            
            if (swatch.type == .stocking) {
                Text(swatch.stitch + " 코")
                Text(swatch.row + " 단")
            } else {
                Text(swatch.width + " cm")
                Text(swatch.height + " cm")
            }
        }
    }
}

#Preview {
    SwatchView(swatch: Swatch(title: "빈티지 코위찬 - 그물", yarn: "아임울4", needle: "5", type: SwatchType.stocking, stitch: "26", row: "28", width: "0", height: "0"))
}
