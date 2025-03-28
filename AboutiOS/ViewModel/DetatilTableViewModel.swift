//
//  DetatilTableViewModel.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/15/25.
//

import Foundation

class DetatilTableViewModel {
    let allSections: [Section] = [
        Section(header: "Table View Cell Style", footer: nil, items: [
            Item(imageName: "list.dash", title: Titles.plainStyle),
            Item(imageName: "list.bullet.below.rectangle", title: Titles.groupedStyle),
            Item(imageName: "list.bullet.rectangle", title: Titles.insetGroupedStyle),
        ]),
        Section(header: "Commit Editing Style", footer: nil, items: [
            Item(imageName: "arrowshape.left.arrowshape.right.fill", title: Titles.swipe),
        ])
    ]
}
