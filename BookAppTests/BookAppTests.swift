//
//  BookAppTests.swift
//  BookAppTests
//
//  Created by Paul Wilkinson on 19/10/20.
//

import XCTest
@testable import BookApp

class BookAppTests: XCTestCase {
    
    var library: Library!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.library = Library()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyLibrary() throws {
        XCTAssert(library.bookList.isEmpty,"Library was not initially empty")
    }
    
    func testSingleAdd() {
        
        let testBook = Book(title: "1984", author: "George Orwell")
        do {
            try library.add(testBook)
            XCTAssert(library.bookList.count == 1)
        }
        catch {
            XCTFail("Unexpected exception \(error)")
        }
    }
    
    func testDuplicateAdd() {
        let testBook = Book(title: "1984", author: "George Orwell")
        do {
            try library.add(testBook)
            try library.add(testBook)
            XCTFail("Library did not throw when adding a duplicate")
        } catch LibraryError.duplicate {
        }
        catch {
            XCTFail("Unexpected exception \(error)")
        }
    }
    
    func testUpdate() {
        
        let newBook = Book(title: "Reamde", author: "Neal Stephenson")
        do {
            try library.add(newBook)
            let updateBook = Book(title: newBook.title+" Updated", author: newBook.author+" Updated", id: newBook.id)
            try library.update(updateBook)
            if let book = library.bookList.first {
                XCTAssert(book.title == updateBook.title && book.author == updateBook.author,"Book was not updated")
            } else {
                XCTFail("Book not found")
            }
            
        } catch {
            XCTFail("Unexpected exception \(error)")
        }
        
    }
    
    func testUpdateMissing() {
        
        let newBook = Book(title: "Reamde", author: "Neal Stephenson")
        do {
            try library.update(newBook)
        } catch LibraryError.notFound {
            
        } catch {
            XCTFail("Unexpected exception \(error)")
        }
        
    }
    
}
