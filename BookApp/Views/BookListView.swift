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
                }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView().environmentObject(MockLibrary()  as Library)
    }
}
