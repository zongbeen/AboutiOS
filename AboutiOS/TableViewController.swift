//
//  TableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/7/25.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let allSections: [(header: String?, items: [(imageName: String, title: String)])] = [
        (nil, [
            ("network", "WebViewController"),
            ("wifi", "Wi-Fi"),
            ("bolt.horizontal", "Bluetooth"),
            ("airplane", "Airplane Mode"),
            ("battery.100", "Battery")
        ]),
        ("General", [
            ("gear", "General"),
            ("magnifyingglass", "Search")
        ]),
        ("Other", [
            ("person.crop.circle", "Profile"),
            ("lock", "Privacy")
        ])
    ]
    private var filteredSections: [(header: String?, items: [(imageName: String, title: String)])] = []
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setupSearchController()
        
        tableView.delegate = self
        tableView.dataSource = self
        filteredSections = allSections  // 초기에는 전체 데이터 사용
    }
    
    //MARK: - navigation title 세팅
    func setNavigationTitle() {
        title = "Table View"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    //MARK: - 검색 컨트롤러 세팅
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredSections.count
    }
    
    //MARK: - 각 섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSections[section].items.count
    }

    //MARK: - 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ??
                   UITableViewCell(style: .default, reuseIdentifier: "Cell")

        let cellData = filteredSections[indexPath.section].items[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: cellData.imageName)
        cell.textLabel?.text = cellData.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    //MARK: - 섹션 헤더 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchController.isActive ? nil : filteredSections[section].header
    }
    
    //MARK: - 셀 선택 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if let viewController = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            default: break
            }
        default: break
        }
    }
}

extension TableViewController: UISearchResultsUpdating {
    //MARK: - 검색 결과
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        
        if searchText.isEmpty {
            filteredSections = allSections
        } else {
            filteredSections = allSections.compactMap { section in
                let filteredItems = section.items.filter { $0.title.lowercased().contains(searchText) }
                return filteredItems.isEmpty ? nil : (header: section.header, items: filteredItems)
            }
        }
        
        tableView.reloadData()
    }
}
