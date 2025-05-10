//
//  SwitchButtonViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 4/7/25.
//

import UIKit

class SwitchButtonViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var pullDownOption = PullDownOption()
    var extensionCell = false
    private let sections: [Section] = [
        Section(header: "Default", footer: nil, items: [
            Item(imageName: "", title: "DefaultCell")
        ]),
        Section(header: "SwitchButton", footer: nil, items: [
            Item(imageName: "", title: "SwitchButtonCell"),
            Item(imageName: "", title: "ExtensionCell")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SwitchButton Table View"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createSwitch(isOn: Bool, action: @escaping (Bool) -> Void) -> UISwitch {
        let switchView = UISwitch()
        switchView.isOn = isOn
        switchView.addAction(
            UIAction { uiAction in
                let switchControl = uiAction.sender as! UISwitch
                action(switchControl.isOn)
            },
            for: .valueChanged
        )
        return switchView
    }
}

extension SwitchButtonViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return sections[section].items.count
        case 1: return extensionCell ? sections[section].items.count : sections[section].items.count - 1
        default: return 0
        }
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
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = nil
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = createSwitch(isOn: extensionCell) { [weak self] isOn in
                    self?.extensionCell = isOn
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            case 1:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
            default: break
            }
        default: break
        }
        return cell
    }
}
