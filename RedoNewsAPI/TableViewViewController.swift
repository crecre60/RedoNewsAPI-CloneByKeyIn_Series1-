      //
      //  ViewController.swift
      //  RedoNewsAPI
      //
      //  Created by Young Ju on 5/18/22.
      //

import UIKit

class TableViewViewController: UIViewController {
      
      private let tableView: UITableView = { () -> UITableView in
            let tv = UITableView()
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
            
            return tv
      }()
      
      private let searchController: UISearchController = { () -> UISearchController in
            let search = UISearchController(searchResultsController: nil)
            search.searchBar.placeholder = "검색창"
            search.searchBar.searchBarStyle = .default
            return search
      }()
      
      private var cellModels = [TableViewCellModel]()
      private var articles = [Article]()
      
      override func viewDidLoad() {
            super.viewDidLoad()
            
            view.addSubview(tableView)
            
            title = "새소식"
            view.backgroundColor = .systemPink
            
            tableView.delegate = self
            tableView.dataSource = self
            navigationItem.searchController = searchController
            searchController.searchBar.delegate = self
            
            getData()
      }
      override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
      }
      
      func getData() {
            
            APICaller.shared.topHeadlines { [weak self] result in
                  switch result {
                        case .success(let articles):
                              self?.articles = articles
                              self?.cellModels = articles.compactMap({ model in
                                    TableViewCellModel(titleInit: model.title,
                                                       subtitleInit: model.description ?? "미상",
                                                       imageURIInit: URL(string: model.urlToImage ?? "")
                                    )
                              })
                              DispatchQueue.main.async {
                                    self?.tableView.reloadData()
                              }
                        case .failure(let error):
                              print(error)
                  }
            }
      }
}

extension TableViewViewController: UITableViewDelegate, UITableViewDataSource {
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell()}
            cell.configure(with: cellModels[indexPath.row])
            return cell
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cellModels.count
      }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let article = articles[indexPath.row]
            
            guard let url = URL(string: article.url) else {
                  return
            }
            
            let vc = WebViewViewController()
            vc.webView.load(URLRequest(url: url))
            navigationController?.pushViewController(vc, animated: true)
      }
}

extension TableViewViewController: UISearchBarDelegate {
      
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            guard let text = searchBar.text, !text.isEmpty else {
                  return
            }
            
            APICaller.shared.searchNews(query: text) { [weak self] result in
                  switch result {
                        case .success(let articles):
                              self?.articles = articles
                              self?.cellModels = articles.compactMap({ models in
                                    TableViewCellModel(titleInit: models.title, subtitleInit: models.description ?? "", imageURIInit: URL(string: models.urlToImage ?? ""))
                              })
                              DispatchQueue.main.async {
                                    self?.tableView.reloadData()
                                    self?.searchController.dismiss(animated: true, completion: nil)
                              }
                        case .failure(let error):
                              print(error)
                  }
            }
      }
}
