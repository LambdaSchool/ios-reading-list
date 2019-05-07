//
//  BookController.swift
//  Reading List
//
//  Created by Mitchell Budge on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("ReadingList.plist")
    } // end of computed property
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        }   catch {
            print("Error saving books: \(error)")
        }
    } // end of save data function
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: booksData)
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
}
