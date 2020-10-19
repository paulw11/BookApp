//
//  BookEditView.swift
//  BookApp
//
//  Created by Paul Wilkinson on 19/10/20.
//

import SwiftUI

struct BookEditView: View {
    @EnvironmentObject var library: Library
    @Environment(\.presentationMode) private var presentationMode
    @State var title: String = ""
    @State var author: String = ""
    var book: Book
    @State private var cancelled = false
    
    var body: some View {
        Form{
            Section(header: Text(book.title)){
                TextField("Title", text: self.$title)
                TextField("Author", text: self.$author)
            }
            Section{
                HStack{
                    Spacer()
                    Button(action: {
                        self.cancelled = true
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    }
                    Spacer()
                }
            }
        }.onDisappear() {
            guard !self.cancelled else {
                return
            }
            let updatedBook = Book(title: self.title, author: self.author, id: self.book.id)
            try? self.library.update(updatedBook)
        }.onAppear() {
            self.title = book.title
            self.author = book.author
        }
    }
}

struct BookEditView_Previews: PreviewProvider {
    static var previews: some View {
        BookEditView(book: Book(title:"The Hitch Hikers Guide to the Galaxy", author:"Douglas Adams"))
    }
}
