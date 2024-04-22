//
//  Color+Ext.swift
//  SwiftDataColor
//  https://ditto.live/blog/swift-hex-color-extension
//  Created by Thach Nguyen Trong on 4/22/24.
//

import SwiftUI

/**
 import SwiftUI
 let hexString = "FF0000" // red color
 let uiColor: UIColor? = UIColor(hex: hexString) // UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
 let color: Color? = Color(hex: hexString) // Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)

 */

extension Color {

    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else { return nil }
        self.init(uiColor: uiColor)
    }

    func toHexString(includeAlpha: Bool = false) -> String? {
        return UIColor(self).toHexString(includeAlpha: includeAlpha)
    }

}
