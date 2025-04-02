//
//  AccessoryTableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/30/25.
//

import UIKit

class AccessoryTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var pullDownOption = PullDownOption()
    
    let dataOptions = ["Data_one", "Data_two", "Data_three"]
    let typeOptions = ["Type_one", "Type_two", "Type_three"]
    let styleOptions = ["Style_one", "Style_two", "Style_three"]
    
    private let sections: [Section] = [
        Section(header: "accessoryType", footer: nil, items: [
            Item(imageName: "", title: ".none"),
            Item(imageName: "", title: ".disclosureIndicator"),
            Item(imageName: "", title: ".detailDisclosureButton"),
            Item(imageName: "", title: ".checkmark"),
            Item(imageName: "", title: ".detailButton")
        ])
        ,
        Section(header: "accessoryView", footer: nil, items: [
            Item(imageName: "", title: "데이터 설정"),
            Item(imageName: "", title: "스타일 설정"),
            Item(imageName: "", title: "타입 설정")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Accessory Table View"
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AccessoryTableViewController: UITableViewDataSource, UITableViewDelegate {
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
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryType = .none
            case 1:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryType = .disclosureIndicator
            case 2:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryType = .detailDisclosureButton
            case 3:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryType = .checkmark
            case 4:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryType = .detailButton
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = PullDownButton(configModel: pullDownOption, keyPath: \.data, options: dataOptions)
            case 1:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = PullDownButton(configModel: pullDownOption, keyPath: \.style, options: styleOptions)
            case 2:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = PullDownButton(configModel: pullDownOption, keyPath: \.type, options: typeOptions)
            default:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = nil
            }
        default: break
        }
        return cell
    }
}
