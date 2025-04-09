//
//  TableViewModel.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/15/25.
//

import Foundation

class TableViewModel {
    private let sections: [Section] = [
        Section(header: "Table View", footer: "This is a table view section", items: [
            Item(imageName: "doc.badge.gearshape.fill", title: "TableView Detail")
        ]),
        Section(header: "Other", footer: nil, items: [
            Item(imageName: "network", title: "WebView")
        ])
    ]
    
    private(set) var filteredSections: [Section] = []
    var onDataUpdated: (() -> Void)?
    
    init() {
        filteredSections = sections
    }
    
    func filterSections(searchText: String) {
        if searchText.isEmpty {
            filteredSections = sections
        } else {
            filteredSections = sections.compactMap { section in
                let filteredItems = section.items.filter { $0.title.lowercased().contains(searchText.lowercased()) }
                return filteredItems.isEmpty ? nil : Section(header: section.header, footer: section.footer, items: filteredItems)
            }
        }
        onDataUpdated?()
    }
}
