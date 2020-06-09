//
//  DataModel.swift
//  JsonAndXml
//
//  Created by Tong Yi on 5/12/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

struct Entertainment: Codable
{
    var title: String
    var detail: String
    
    enum CodingKeys: String, CodingKey
    {
        case title
        case detail
        
        
    }
}

// MARK: - Encodable
extension Entertainment
{
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(detail, forKey: .detail)
    }
}

// MARK: - Decodable

extension Entertainment
{
    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        detail = try container.decode(String.self, forKey: .detail)
    }
}

let dataSouce: [[String: Any]] = [
    ["title": "Naruto", "detail": "Anime RPG Game"],
    ["title": "Mobile Legends", "detail": "Play with the world!"],
    ["title": "PUBG", "detail": "2nd Anniversay: 2gether We Play"],
    ["title": "The Things We Cannot Say", "detail": "Kelly Rimmer"],
    ["title": "A Study in Scarlet", "detail": "Arthur Conan Doyle"],
    ["title": "Harry Potter and the Philosopher's Stone", "detail": "J.K Rollin"],
    ["title": "Perfet", "detail": "Ed Sheeran"],
    ["title": "Soldier", "detail": "Gavin DeGraw"],
    ["title": "Venom", "detail": "Eminem"]
]

struct Book: Codable
{
    var bookTitle: String
    var bookAuthor: String
}

