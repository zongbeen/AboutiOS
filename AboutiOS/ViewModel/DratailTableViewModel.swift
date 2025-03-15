//
//  DratailTableViewModel.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/15/25.
//

import Foundation

class DetatilTableViewModel {
    let allSections: [Section] = [
        Section(header: nil, items: [
            Item(imageName: "text.line.first.and.arrowtriangle.forward", title: Titles.plainStyle),
            Item(imageName: "list.dash", title: Titles.groupedStyle),
            Item(imageName: "list.bullet.rectangle", title: Titles.insetGroupedStyle)
        ])
    ]
}
