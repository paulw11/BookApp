//
//  BookListView.swift
//  BookApp
//
//  Created by Paul Wilkinson on 19/10/20.
//

import SwiftUI

struct BookListView: View {
    
    @EnvironmentObject var library: Library
    @State var showAddSheet = false
    var body: some View {
        NavigationView {
            List {
                ForEach(library.bookList) { book in
                    NavigationLink(destination: BookEditView(book: book)) {
                        BookRowView(book: book)
                    }
                }.onDelete(perform: delete)
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showAddSheet.toggle()
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(Font.system(.title))
                                    }
            )
            .navigationTitle("My library")
            .listStyle(GroupedListStyle())
        }.sheet(isPresented: $showAddSheet) {
            AddSheetView()
        }
    }
    
    func delete(at offsets: IndexSet) {
        let books = offsets.map { self.library.bookList[$0]
            
        }
        for book in books {
            try? self.library.delete(book)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView().environmentObject(MockLibrary()  as Library)
    }
}
