//
//  Library.swift
//  BookApp
//
//  Created by Paul Wilkinson on 19/10/20.
//

import Foundation


class Library: ObservableObject {
    
    open var books:[UUID:Book]
    
    @Published private(set) var bookList: [Book]
    
    init() {
        self.books = [UUID:Book]()
        self.bookList = []
        try! self.load()
    }
    
    public func add(_ book: Book) throws {
        if let _ = self.books[book.id]  {
            throw LibraryError.duplicate
        }
        self.books[book.id] = book
        self.updateBookList()
        try self.save()
    }
    
    public func update(_ book: Book) throws {
        guard let _ = self.books[book.id] else {
            throw LibraryError.notFound
        }
        self.books[book.id] = book
        self.updateBookList()
        try self.save()
    }
    
    public func delete(_ book: Book) throws {
        self.books[book.id] = nil
        self.updateBookList()
        try self.save()
    }
    
    public func book(withID id:UUID) -> Book? {
        return self.books[id]
    }
    
    open func save() throws {
        
    }
    
    open func load() throws {
        
    }
    
    private func updateBookList() {
        self.bookList =  self.books.values.sorted { $0.title < $1.title }
    }
}

enum LibraryError: Error {
    case duplicate
    case notFound
}

struct Book: Identifiable, Codable {
    var id: UUID
    var title: String
    var author: String
    
    init(title: String, author: String, id: UUID? = nil) {
        self.title = title
        self.author = author
        self.id = id ?? UUID()
    }
    
}
