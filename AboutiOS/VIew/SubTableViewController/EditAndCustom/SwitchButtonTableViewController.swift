//
//  SwitchButtonTableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 4/7/25.
//

import UIKit

class SwitchButtonTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var pullDownOption = PullDownOption()
    
    private let sections: [Section] = [
        Section(header: "Uknown", footer: nil, items: [
            Item(imageName: "", title: "Uknown")
        ]),
        Section(header: "Uknown", footer: nil, items: [
            Item(imageName: "", title: "Uknown")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SwitchButton Table View"
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SwitchButtonTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header == nil ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footer == nil ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        return cell
    }
}
