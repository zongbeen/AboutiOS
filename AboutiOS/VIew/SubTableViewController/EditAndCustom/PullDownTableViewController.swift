//
//  PullDownTableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/30/25.
//

import UIKit

struct PullDownOption {
    var data: String = "Data1"
    var type: String = "Type1"
    var style: String = "Style1"
}

class PullDownTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var configModel = PullDownOption()
    
    let dataOptions = ["Data1", "Data2", "Data3"]
    let typeOptions = ["Type1", "Type2", "Type3"]
    let styleOptions = ["Style1", "Style2", "Style3"]
    
    private let sections: [Section] = [
        Section(header: "Header1", footer: nil, items: [
            Item(imageName: "", title: "데이터 설정"),
            Item(imageName: "", title: "스타일 설정")
        ]),
        Section(header: "Header2", footer: nil, items: [
            Item(imageName: "", title: "타입 설정"),
            Item(imageName: "", title: "비어있는 셀"),
            Item(imageName: "", title: "비어있는 셀")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Pull Down Table View"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func makeSelectionButton<T>(titleKeyPath: KeyPath<PullDownOption, T>,
                                        updateKeyPath: WritableKeyPath<PullDownOption, T>,
                                        options: [T]) -> UIButton {
        let button = UIButton(type: .system)
        button.showsMenuAsPrimaryAction = true
        setButtonTitle(button, value: configModel[keyPath: titleKeyPath])
        
        button.menu = UIMenu(children: options.map { option in
            UIAction(title: "\(option)") { [weak self] _ in
                self?.configModel[keyPath: updateKeyPath] = option
                self?.setButtonTitle(button, value: option)
            }
        })
        
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .trailing
        button.sizeToFit()
        button.frame.size = CGSize(width: max(button.frame.width, 80), height: max(button.frame.height, 30))
        
        return button
    }
    
    private func setButtonTitle<T>(_ button: UIButton, value: T) {
        let image = UIImage(systemName: "chevron.up.chevron.down")!
        let attributedString = NSMutableAttributedString(string: "\(value) ")
        let attachment = NSTextAttachment()
        attachment.image = image.withRenderingMode(.alwaysTemplate)
        attributedString.append(NSAttributedString(attachment: attachment))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSRange(location: 0, length: attributedString.length))
        button.setAttributedTitle(attributedString, for: .normal)
    }
}

extension PullDownTableViewController: UITableViewDataSource, UITableViewDelegate {
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
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = makeSelectionButton(titleKeyPath: \PullDownOption.data,
                                                           updateKeyPath: \PullDownOption.data,
                                                           options: dataOptions)
            case 1: 
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = makeSelectionButton(titleKeyPath: \PullDownOption.style,
                                                           updateKeyPath: \PullDownOption.style,
                                                           options: styleOptions)
            case 2: cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = makeSelectionButton(titleKeyPath: \PullDownOption.type,
                                                           updateKeyPath: \PullDownOption.type,
                                                           options: typeOptions)
            case 1: cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
            case 2: cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
            default: break
            }
        default: break
        }
        return cell
    }
}
