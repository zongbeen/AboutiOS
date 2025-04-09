//
//  DetatilTableViewModel.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/15/25.
//

import Foundation

class DetatilTableViewModel {
    let sections: [Section] = [
        Section(header: "Table View Cell Style", footer: nil, items: [
            Item(imageName: "list.dash", title: Titles.plainStyle),
            Item(imageName: "list.bullet.below.rectangle", title: Titles.groupedStyle),
            Item(imageName: "list.bullet.rectangle", title: Titles.insetGroupedStyle),
        ]),
        Section(header: "Cell Editing & Custom Actions", footer: nil, items: [
            Item(imageName: "arrowshape.left.arrowshape.right.fill", title: Titles.swipe),
            Item(imageName: "button.horizontal.top.press.fill", title: Titles.accessory),
            Item(imageName: "switch.2", title: Titles.switchButton)
        ])
    ]
}
