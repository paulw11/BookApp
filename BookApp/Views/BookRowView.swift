//
//  BookRowView.swift
//  BookApp
//
//  Created by Paul Wilkinson on 19/10/20.
//

import SwiftUI

struct BookRowView: View {
    var book: Book
    var body: some View {
        VStack(alignment: .leading, spacing:8) {
            Text(book.title).font(.headline)
            Text(book.author).font(.subheadline)
        }
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(book: Book(title:"The Hitch Hikers Guide to the Galaxy", author:"Douglas Adams"))
    }
}
