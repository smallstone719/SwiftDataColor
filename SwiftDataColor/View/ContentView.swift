//
//  ContentView.swift
//  SwiftDataColor
//
//  Created by Thach Nguyen Trong on 4/22/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showColorList: Bool = false
    @State private var selectedColor: DummyColor = .none
    
    @Query private var storedColors: [ColorModel]
    var body: some View {
        NavigationStack {
            List {
                ForEach(storedColors) { color in
                    HStack {
                        Circle()
                            .fill(Color(color.color).gradient)
                            .frame(width: 35, height: 35)
                        Text(color.name)
                    }
                }
            }
            .navigationTitle("My Colors")
            .toolbar {
                Button("Add") {
                    showColorList.toggle()
                }
            }
        }
        .sheet(isPresented: $showColorList) {
            NavigationStack {
                List {
                    Picker("Select", selection: $selectedColor) {
                        ForEach(DummyColor.allCases, id: \.rawValue) {
                            Text($0.rawValue)
                                .tag($0)
                        }
                    }
                }
                .navigationTitle("Choose a color")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel", role: .destructive) {
                            showColorList.toggle()
                            selectedColor = .none
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add", role: .destructive) {
                            let colorModel = ColorModel(name: selectedColor.rawValue, color: selectedColor.color)
                            modelContext.insert(colorModel)
                            /// Close sheet
                            showColorList.toggle()
                            selectedColor = .none
                            
                        }
                        .disabled(selectedColor == .none)
                    }
                }
            }
            .interactiveDismissDisabled()
            .presentationDetents([.height(200)])
        }
    }
}

#Preview {
    ContentView()
}

@Model
class ColorModel {
    var name: String
    @Attribute(.transformable(by: ColorTransformer.self))
    var color: UIColor
    
    init(name: String, color: Color) {
        self.name = name
        self.color = UIColor(color)
    }
}

class ColorTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
            
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
            
        } catch {
            return nil
        }
    }
    
    override class func transformedValueClass() -> AnyClass {
        return UIColor.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    static func register() {
        ValueTransformer.setValueTransformer(ColorTransformer(), forName: .init("ColorTransformer"))
    }
}

enum DummyColor: String, CaseIterable {
    case red    = "Red"
    case blue   = "Blue"
    case green  = "Green"
    case yellow = "Yellow"
    case purple = "Purple"
    case brown  = "Brown"
    case black  = "Black"
    case none   = "None"
    
    var color: Color {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .purple:
            return .purple
        case .brown:
            return .brown
        case .black:
            return .black
        case .none:
            return .clear
        }
    }
}
