//
//  InsetGroupedTableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/19/25.
//

import UIKit

class InsetGroupedTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let allSections: [Section] = [
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
        title = "Inset Grouped Table View"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension InsetGroupedTableViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return allSections.count
    }
    
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
        return allSections[section].header == nil ? 20 : 30
    }
    
    //MARK: - 섹션 footer 설정
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return allSections[section].footer
    }
    
    //MARK: - 섹션 footer의 높이 설정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }

    //MARK: - 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ??
        UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let cellData = allSections[indexPath.section].items[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: cellData.imageName)
        cell.textLabel?.text = cellData.title
        
        return cell
    }
    
    //MARK: - 셀 선택 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



