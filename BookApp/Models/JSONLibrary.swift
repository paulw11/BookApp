//
//  JSONLibrary.swift
//  BookApp
//
//  Created by Paul Wilkinson on 19/10/20.
//

import Foundation

class JSONLibrary: Library {
    
    private var filename: String
    
    private let fm = FileManager.default
    
    init(filename: String = "Library") {
        self.filename = filename
        super.init()
    }
    
    override func load() throws {
        
        let url = try self.fileURL()
        
        if fm.fileExists(atPath: url.path) {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let library = try decoder.decode([Book].self, from: jsonData)
            for book in library {
                try self.add(book)
            }
        }
    }
    
    override func save() throws {
        let url = try self.fileURL()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let JsonData = try encoder.encode(self.bookList)
        try JsonData.write(to: url)
    }
    
    private func fileURL() throws -> URL {
        let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
        let subUrl = documentDirectory.appendingPathComponent("\(self.filename).json")
        return subUrl
    }
}
