//
//  iTourApp.swift
//  iTour
//
//  Created by Artem Golovchenko on 2024-11-01.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
