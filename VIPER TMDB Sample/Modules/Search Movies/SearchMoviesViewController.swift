//
//  SearchMoviesViewController.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 01/04/22.
//

import UIKit

class SearchMoviesViewController: TemplateViewController {
    var presenter: SearchMoviesPresenter!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.tintColor = .white
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.textColor = .white
            searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            searchBar.searchTextField.tintColor = .lightGray
            searchBar.searchTextField.leftView?.tintColor = .lightGray
        } else {
            searchBar.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            searchBar.tintColor = .lightGray
            searchBar.searchBarStyle = .minimal
            searchBar.barTintColor = .black
        }
    
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tabelView = UITableView()
        tabelView.backgroundColor = .clear
        tabelView.separatorStyle = .none
        tabelView.showsVerticalScrollIndicator = false
        tabelView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tabelView.register(SearchLocalTermsCell.self, forCellReuseIdentifier: String(describing: SearchLocalTermsCell.self))
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.showsHorizontalScrollIndicator = false
        return tabelView
    }()
    
    private lazy var recentHeaderView: UIView = {
        let headerView = UIView(frame: .zero)
        let recentLabel = UILabel()
        recentLabel.text = "Recém procurados"
        recentLabel.textColor = .blue
        headerView.addSubview(recentLabel)
        recentLabel.pinToSuperview(forAtrributes: [.leading], constant: 16)
        recentLabel.pinToSuperview(forAtrributes: [.centerY])
        return headerView
    }()
    
    private lazy var searchBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearhButton))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.handleShowSearchButton()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.viewWillDisappear(animated: animated)
    }
    
    
    
    private func setupView() {
        self.setupNavigationBar()
        self.setupViewLayout()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupViewLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.pinEdgesToSuperview()
    }
    
    @objc func didTapSearhButton() {
        self.presenter.handleShowSearchButton()
    }
}

extension SearchMoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOrRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.presenter.viewMode {
        case .search:
            guard let searchLocalTermsCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchLocalTermsCell.self), for: indexPath) as? SearchLocalTermsCell else {
                fatalError("Unresolved Error, Couldn't load cell with identifier \(String(describing: SearchLocalTermsCell.self))")
            }
            self.presenter.config(searchCell: searchLocalTermsCell, at: indexPath)
            return searchLocalTermsCell
            
        case .result:
            guard let searchMoviesCell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell  else {
                fatalError("Unresolved Error, Couldn't load cell with identifier \(String(describing: MovieCell.self))")
            }
            self.presenter.config(cell: searchMoviesCell, at: indexPath)
            return searchMoviesCell
        }
    }
}

extension SearchMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.presenter.viewMode == .search ? 40 : (self.view.frame.height / 3)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.presenter.viewMode == .search ? recentHeaderView : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.presenter.viewMode == .search ? 40 : 0
    }
}

extension SearchMoviesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Apagar"
        self.searchBar.showsCancelButton = true
        self.searchBar(shouldBecomeFirstResponder: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.searchBarCancelButtonClicked()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.presenter.searchBarSearchButtonClicked(with: searchText)
    }
}

extension SearchMoviesViewController : SearchMoviesViewProtocol {
    func setupViewFor(mode: SearchMoviesViewMode) {
        switch mode {
        case .search:
            self.navigationItem.titleView = self.searchBar
            self.navigationItem.rightBarButtonItem = nil
        case .result:
            self.navigationItem.titleView = nil
            self.navigationItem.rightBarButtonItem = self.searchBarButtonItem
            self.searchBar.text = ""
        }
        self.tableView.reloadData()
        self.navigationItem.title = self.presenter.title
    }
    
    func searchBar(shouldBecomeFirstResponder: Bool) {
        _ = shouldBecomeFirstResponder ?
            self.searchBar.becomeFirstResponder() : self.searchBar.resignFirstResponder()
    }
    
    func updateSearchBarText(_ text: String) {
        self.searchBar.text = text
    }
    
    func updateSearchResult() {
        self.tableView.reloadData()
    }
}
