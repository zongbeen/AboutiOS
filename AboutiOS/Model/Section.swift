//
//  Section.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/15/25.
//

struct Section: Codable {
    let header: String?
    let footer: String?
    var items: [Item] // var 사용 가능
}

struct Item: Codable {
    let imageName: String
    let title: String
}
