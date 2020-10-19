//
//  AddSheetView.swift
//  BookApp
//
//  Created by Paul Wilkinson on 19/10/20.
//

import SwiftUI

struct AddSheetView: View {
    @State private var title = ""
    @State private var author = ""
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var library: Library
    var body: some View {
        
        Form{
            Section(header: Text(self.title.isEmpty ? "Enter the details of the book" : self.title)){
                TextField("Title", text: $title)
                TextField("Author", text: $author)
            }
            
            Section{
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            let newBook = Book(title: self.title, author: self.author)
                            try? self.library.add(newBook)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Add")
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct AddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSheetView()
    }
}
