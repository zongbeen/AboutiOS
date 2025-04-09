//
//  PlainTableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/19/25.
//

import UIKit

class PlainTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let sections: [Section] = [
        Section(header: "Header1", footer: "footer1", items: [
            Item(imageName: "tablecells.fill", title: "Cell1"),
            Item(imageName: "tablecells.fill", title: "Cell2"),
            Item(imageName: "tablecells.fill", title: "Cell3")
        ]),
        Section(header: "Header2", footer: nil, items: [
            Item(imageName: "tablecells.fill", title: "Cell1"),
            Item(imageName: "tablecells.fill", title: "Cell2"),
            Item(imageName: "tablecells.fill", title: "Cell3")
        ]),
        Section(header: "Header3", footer: "footer3", items: [
            Item(imageName: "tablecells.fill", title: "Cell1"),
            Item(imageName: "tablecells.fill", title: "Cell2"),
            Item(imageName: "tablecells.fill", title: "Cell3")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Plain Table View"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PlainTableViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //MARK: - 각 섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    //MARK: - 섹션 header 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }

    //MARK: - 섹션 header의 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header == nil ? 0 : 30
    }

    //MARK: - 섹션 footer 설정
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }

    //MARK: - 섹션 footer의 높이 설정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footer == nil ? 0 : 30
    }

    //MARK: - 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ??
        UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let cellData = sections[indexPath.section].items[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: cellData.imageName)
        cell.textLabel?.text = cellData.title
        
        return cell
    }
    
    //MARK: - 셀 선택 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

