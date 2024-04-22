//
//  ColorView.swift
//  SwiftDataColor
//  https://github.com/diniska/swiftui-system-colors.git
//  Created by Thach Nguyen Trong on 4/22/24.
//

import SwiftUI
import SystemColors

struct ColorView: View {
    var body: some View {
        /// Color(uiColor: UIColor(hex: "3f3f3f")!).ignoresSafeArea()
        ZStack {
            VStack(spacing: 0) {
                ColorItemView(
                    color:  Color(.systemGroupedBackground),
                    colorName: "Color(.systemGroupedBackground)"
                )
                
                ColorItemView(
                    color:   Color(.secondarySystemGroupedBackground),
                    colorName: "Color(.secondarySystemGroupedBackground)"
                )
                
                ColorItemView(
                    color:   Color(.separator),
                    colorName: "Color(.separator)"
                )
                
                ColorItemView(
                    /// Sử dụng SystemColors Package
                    color:   Color.placeholderText,
                    colorName: "Color.placeholderText"
                )
            }
           
        }.ignoresSafeArea()
    }
}

#Preview {
    ColorView()
        .preferredColorScheme(.dark)
}

struct ColorItemView: View {
    let color: Color
    let colorName: String
    var body: some View {
        ZStack {
            color
            Text(colorName)
                .fontWidth(.condensed)
        }
    }
}
