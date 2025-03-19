//
//  TableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/7/25.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        title = "Table View"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.filteredSections.count
    }
    
    //MARK: - 각 섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredSections[section].items.count
    }

    //MARK: - 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ??
        UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let cellData = viewModel.filteredSections[indexPath.section].items[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: cellData.imageName)
        cell.textLabel?.text = cellData.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK: - 섹션 header 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchController.isActive ? nil : viewModel.filteredSections[section].header
    }

    //MARK: - 섹션 footer 설정
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let footer = viewModel.filteredSections[section].footer
        return searchController.isActive ? nil : viewModel.filteredSections[section].footer
    }
    //MARK: - 섹션 header의 높이 설정
    //UITableView.Style.insetGrouped를 사용할 때, 첫 번째 섹션 헤더가 테이블 뷰의 상단 contentInset이나 sectionHeaderHeight와 상호작용하면서 가려짐
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.filteredSections[section].header == nil ? 0 : 30
    }
    
    //MARK: - 섹션 footer의 높이 설정
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.filteredSections[section].footer == nil ? 0 : 30
    }
    
    //MARK: - 셀 선택 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = viewModel.filteredSections[indexPath.section].items[indexPath.row]
        
        switch selectedItem.title {
        case Titles.tableViewDetail:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "DetatilTableViewController") as? DetatilTableViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        case Titles.webView:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        default: break
        }
    }
}

extension TableViewController: UISearchResultsUpdating {
    //MARK: - 검색 결과
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        viewModel.filterSections(searchText: searchText)
    }
}
