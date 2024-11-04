//
//  ContentView.swift
//  iTour
//
//  Created by Artem Golovchenko on 2024-11-01.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    
    //@Query(sort: \Destination.priority, order: .reverse) var destinations: [Destination]
    
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle("iTour")
                .searchable(text: $searchText)
                .animation(.default, value: searchText)
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .toolbar {
                    Button("Add Destination", systemImage: "plus", action: addDestination)
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder.animation()) {
                            Text("Name")
                                .tag(SortDescriptor(\Destination.name))
                            
                            Text("Priority")
                                .tag(SortDescriptor(\Destination.priority, order: .reverse))
                            
                            Text("Date")
                                .tag(SortDescriptor(\Destination.date))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    func addDestination() {
        let destination = Destination()
        context.insert(destination)
        path = [destination]
    }
    
}

#Preview {
    ContentView()
}

//add swipe to delete for sights
//use array to init listing view
//add new picker for future places to visit
