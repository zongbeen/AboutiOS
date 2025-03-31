//
//  PullDownTableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/30/25.
//

import UIKit

struct PullDownOptionModel {
    var data: String = "Data1"
    var type: String = "Type1"
}

class PullDownTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var configModel = PullDownOptionModel()
    let dataOptions = ["Data1", "Data2", "Data3"]
    let typeOptions = ["Type1", "Type2", "Type3"]
    var selectedData: String = "Data1"
    var selectedType: String = "Type1"
    
    private let allSections: [Section] = [
        Section(header: "Header1", footer: "footer1", items: [
            Item(imageName: "", title: "데이터 설정"),
            Item(imageName: "", title: "비어있는 셀"),
            Item(imageName: "", title: "비어있는 셀")
        ]),
        Section(header: "Header2", footer: nil, items: [
            Item(imageName: "", title: "타입 설정"),
            Item(imageName: "", title: "비어있는 셀"),
            Item(imageName: "", title: "비어있는 셀")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Pull Down In The Table View"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(rightButtonTapped))
    }
    
    @objc private func leftButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func rightButtonTapped() {
        dismiss(animated: true)
    }
    
    private func createSelectionButton<T>(titleKeyPath: KeyPath<PullDownOptionModel, T>, updateKeyPath: WritableKeyPath<PullDownOptionModel, T>, options: [T]) -> UIButton {
        let button = UIButton(type: .system)
        button.showsMenuAsPrimaryAction = true
        updateButtonTitle(button, value: configModel[keyPath: titleKeyPath])
        
        let menuItems = options.map { option in
            UIAction(title: "\(option)") { [weak self] _ in
                self?.configModel[keyPath: updateKeyPath] = option
                self?.updateButtonTitle(button, value: option)
            }
        }
        
        button.menu = UIMenu(children: menuItems)
        button.tintColor = .systemGray
        button.contentHorizontalAlignment = .trailing
        button.sizeToFit()
        button.frame.size = CGSize(width: max(button.frame.width, 80),
                                   height: max(button.frame.height, 30))
        
        return button
    }
    
    private func updateButtonTitle<T>(_ button: UIButton, value: T) {
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
    //MARK: - 각 섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSections[section].items.count
    }
    
    //MARK: - 섹션 header 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allSections[section].header
    }
    
    //MARK: - 섹션 header의 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return allSections[section].header == nil ? 0 : 30
    }
    
    //MARK: - 섹션 footer 설정
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return allSections[section].footer
    }
    
    //MARK: - 섹션 footer의 높이 설정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return allSections[section].footer == nil ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = allSections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = createSelectionButton(titleKeyPath: \PullDownOptionModel.data,
                                                           updateKeyPath: \PullDownOptionModel.data,
                                                           options: dataOptions)
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = allSections[indexPath.section].items[indexPath.row].title
                cell.accessoryView = createSelectionButton(titleKeyPath: \PullDownOptionModel.type,
                                                           updateKeyPath: \PullDownOptionModel.type,
                                                           options: typeOptions)
            default: break
            }
        default: break
        }
        return cell
    }
}
