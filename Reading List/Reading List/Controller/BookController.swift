//
//  BookController.swift
//  Reading List
//
//  Created by Jarren Campos on 2/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    private var readingListURL: URL?{
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    @discardableResult func createBook(named title: String, withReason reasonToRead: String, beenRead hasBeenRead: Bool) -> Book{
        
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    @discardableResult func deleteBook(at index: Int) -> Book {
        books.remove(at: index)
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch{
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode ([Book].self, from: data)
        } catch {
            print("error loading books data: \(error)")
        }
    }
    
    func updateHasBeenRead(for book: Book) -> Book {
        var myBook = book
        if myBook.hasBeenRead == false{
            myBook.hasBeenRead = true
            return myBook
        } else{
            myBook.hasBeenRead = false
            return myBook
        }
    }
    
//    func updateTitleReason(for book: Book) -> Book {
//        var myBook = book
//        
//    }
}
