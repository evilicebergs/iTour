//
//  DestinationListingView.swift
//  iTour
//
//  Created by Artem Golovchenko on 2024-11-04.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    
    @Environment(\.modelContext) var context
    
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(destination.name)
                                .font(.headline)
                            
                            Text(destination.date.formatted(date: .long, time: .shortened))
                        }
                        Spacer()
                        Image(systemName: destination.toVisit ? "star.fill" : "star")
                            .foregroundStyle(destination.toVisit ? .yellow : .red)
                            .onTapGesture {
                                destination.toVisit.toggle()
                            }
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    
    init(sort: SortDescriptor<Destination>, searchString: String, date: Int) {
            _destinations = Query(filter: #Predicate {
                if searchString.isEmpty {
                    if date == 0 {
                        return true
                    } else if date == 1 {
                        return $0.toVisit == true
                    } else {
                        return $0.toVisit == false
                    }
                } else {
                    return $0.name.localizedStandardContains(searchString)
                }
            }, sort: [sort, SortDescriptor(\Destination.name)])
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            context.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "", date: 0)
}
