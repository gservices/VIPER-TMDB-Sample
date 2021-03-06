//
//  PopularMoviesViewController.swift
//  VIPER TMDB Sample
//
//  Created by Carlos Henrique Gava on 29/03/22.
//

import UIKit

class PopularMoviesViewController: TemplateViewController {
    var presenter: PopularMoviesPresentationProtocol!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = (self.view.frame.height) / 3
        tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 40))
        let spinner = UIActivityIndicatorView()
        
        if #available(iOS 13.0, *) {
            spinner.style = .medium
        } else {
            spinner.style = .gray
        }
        
        spinner.color = .red
        footerView.addSubview(spinner)
        spinner.pinToSuperview(forAtrributes: [.centerX, .centerY])
        spinner.startAnimating()
        return footerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.setupViewLayout()
    }
    
    private func setupViewLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.pinEdgesToSuperview()
    }
}

extension PopularMoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOrRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else {
            fatalError("Erro n??o resolvido, n??o foi poss??vel carregar a c??lula com identificador \(String(describing: MovieCell.self))")
        }
        
        self.presenter.config(cell: cell, at: indexPath)
        
        return cell
    }
    
}

extension PopularMoviesViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - (scrollView.frame.size.height * 4) {
            self.presenter.didScrollToEnd()
        }
    }
}

extension PopularMoviesViewController: PopularMoviesViewProtocol {
    func updateView() {
        self.tableView.reloadData()
    }
    
    func showTableViewFooter() {
        self.tableView.tableFooterView = self.footerView
    }
    
    func hideTableViewFooter() {
        self.tableView.tableFooterView = nil
    }
}
