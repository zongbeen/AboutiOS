//
//  TableViewModel.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/15/25.
//

import Foundation

class TableViewModel {
    private let allSections: [Section] = [
        Section(header: "Table View", items: [
            Item(imageName: "doc.badge.gearshape.fill", title: Titles.tableViewDetail)
        ]),
        Section(header: "Other", items: [
            Item(imageName: "network", title: Titles.webView)
        ])
    ]
    
    private(set) var filteredSections: [Section] = []
    var onDataUpdated: (() -> Void)?
    
    init() {
        filteredSections = allSections
    }
    
    func filterSections(searchText: String) {
        if searchText.isEmpty {
            filteredSections = allSections
        } else {
            filteredSections = allSections.compactMap { section in
                let filteredItems = section.items.filter { $0.title.lowercased().contains(searchText.lowercased()) }
                return filteredItems.isEmpty ? nil : Section(header: section.header, items: filteredItems)
            }
        }
        onDataUpdated?()
    }
}
