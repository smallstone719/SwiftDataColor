//
//  SwiftDataColorApp.swift
//  SwiftDataColor
//
//  Created by Thach Nguyen Trong on 4/22/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataColorApp: App {
    init() {
        ColorTransformer.register()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ColorModel.self)
        }
    }
}
