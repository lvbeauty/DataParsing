//
//  ViewController.swift
//  JsonAndXml
//
//  Created by Tong Yi on 5/12/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class XMLTableViewController: UITableViewController
{

    var books = [Book]()   //collection is a container
    var bookTitle = String()
    var bookAuthor = String()
    var elementName = String()
    let bundle = Bundle.main
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        xmlParserSetup()
    }
    
    func setupUI()
    {
        self.tableView.tableFooterView = UIView()
        self.title = "XML"
    }
    
    // MARK: - Table view data source & delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "xmlCell", for: indexPath)
        cell.textLabel?.text = books[indexPath.row].bookTitle
        cell.detailTextLabel?.text = books[indexPath.row].bookAuthor
        cell.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
        return cell
    }
    

}

//MARK: - XML File parsing

extension XMLTableViewController: XMLParserDelegate
{
    func xmlParserSetup()
    {
        guard let xmlFileURL = bundle.url(forResource: "Books", withExtension: "xml") else {return}
        if let xmlData = XMLParser(contentsOf: xmlFileURL)
        {
            xmlData.delegate = self
            xmlData.parse()
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

//        if elementName == "book" {
//            bookTitle = String()
//            bookAuthor = String()
//        }

        self.elementName = elementName
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book" {
            let book = Book(bookTitle: bookTitle, bookAuthor: bookAuthor)
            books.append(book)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "title" {     //populating/filling data
                bookTitle = data
            } else if self.elementName == "author" {
                bookAuthor = data
            }
        }
    }
}

