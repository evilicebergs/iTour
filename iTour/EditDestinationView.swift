//
//  EditDestinationView.swift
//  iTour
//
//  Created by Artem Golovchenko on 2024-11-01.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    
    @Bindable var destination: Destination
    @State private var newSightName = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    
                    Button("Add", action: addSight)
                    
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
}

#Preview {
    struct PreviewWrapper: View {
        func someView() -> some View {
            do {
                let config = ModelConfiguration(isStoredInMemoryOnly: true)
                let container = try ModelContainer(for: Destination.self, configurations: config)
                let example = Destination(name: "Example Destination", details: "so mamammamammmamammammaammmamammamamamhkjshfJCncncnnncncccnnncncncncnncncnccncnnncncncnnccnncncncccnncncncnncnncncnncnccnnccn.")
                return EditDestinationView(destination: example)
                    .modelContainer(container)
            } catch {
                fatalError("Failed to create model")
            }
            
        }
            
            var body: some View {
                someView()
            }
        }
        return PreviewWrapper()
    
    
    
}
