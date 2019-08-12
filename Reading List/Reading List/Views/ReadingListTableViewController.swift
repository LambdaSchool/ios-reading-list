//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Casualty on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    var bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        switch indexPath.section {
        case 0:
            return bookController.readBooks[indexPath.row]
        case 1:
            return bookController.unreadBooks[indexPath.row]
        default:
            return Book(title: "", reasonToRead: "", rating: 5)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unreadBooks.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingBookCell", for: indexPath) as? ReadingListTableViewCell else { return UITableViewCell() }
        cell.book = bookFor(indexPath: indexPath)
        cell.delegate = self
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Read Books - Total: \(bookController.readBooks.count)"
        case 1:
            return "Unread Books - Total: \(bookController.unreadBooks.count)"
        default:
            return nil
        }
    }
    
    // Deleting Cell

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { bookController.deleteBook(bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? BookDetailViewController else { return }
        
        vc.bookController = bookController
        if segue.identifier == "BookDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.book = bookFor(indexPath: indexPath)
            }
        }
    }
}

extension ReadingListTableViewController: ReadingListDelegate {
    func toggleHasBeenRead(for cell: ReadingListTableViewCell) {
        guard let book = cell.book else { return }
        bookController.updateRead(for: book)
        tableView.reloadData()
    }
}
