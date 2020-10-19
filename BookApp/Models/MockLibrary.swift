//
//  MockLibrary.swift
//  BookApp
//
//  Created by Paul Wilkinson on 19/10/20.
//

import Foundation

class MockLibrary: Library {
    override init() {
        super.init()
        let mobyDick = Book(title: "Moby Dick", author: "Herman Melville")
        let hhgttg = Book(title:"The Hitch Hikers Guide to the Galaxy", author:"Douglas Adams")
        let reamde = Book(title:"Reamde", author: "Neal Stephenson")
        try? self.add(mobyDick)
        try? self.add(hhgttg)
        try? self.add(reamde)
    }
}
