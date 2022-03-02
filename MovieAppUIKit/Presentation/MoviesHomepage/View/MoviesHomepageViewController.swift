//
//  ViewController.swift
//  MovieAppUIKit
//
//  Created by Paul on 14/02/2022.
//

import UIKit

class MoviesHomepageViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var topRatedButton: UIButton!
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    
    // MARK: - Private Properties
    
    private var viewModel: MoviesHomepageViewModel!
    private var movies: [MoviesListItemViewModel] = []
    
    // MARK: - Public Properties
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let network = NetworkService()
        let service = MoviesService(network: network)
        let repository = MoviesRepository(service)
        let popularUseCase = FetchPopularMoviesUseCase(moviesRepository: repository)
        let topRatedUseCase = DefaultFetchTopRatedMoviesUseCase(moviesRepository: repository)
        self.viewModel = DefaultMoviesHomepageViewModel(fetchPopularMoviesUseCase: popularUseCase, fetchTopRatedMoviesUseCase: topRatedUseCase, delegate: self)
        
        self.setupViews()
        self.setupTableView()
    }
    
    
    // MARK: - Private
    
    private func setupViews() {
        self.title = viewModel.screenTitle
    }
    
    private func setupTableView() {
        self.movieListTableView.dataSource = self
        self.movieListTableView.register(UINib(nibName: MoviesListItemCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MoviesListItemCell.reuseIdentifier)
        
        self.movieListTableView.estimatedRowHeight = MoviesListItemCell.height
        self.movieListTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    // MARK: - IBActions
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        print(searchTextField.text!)
    }
    
    @IBAction func popularButtonTapped(_ sender: Any) {
        self.viewModel.didSearchPopularMovies()
    }
    
    @IBAction func topRatedButtonTapped(_ sender: Any) {
        self.viewModel.didSearchTopRatedMovies()
    }
    
    
    // MARK: - Helpers

    
    
}

// TODO: Make into separate MoviesHomepageListTableViewController
extension MoviesHomepageViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.movieListTableView.dequeueReusableCell(withIdentifier: MoviesListItemCell.reuseIdentifier,
                                                                     for: indexPath) as? MoviesListItemCell else {
            // TODO: assertionFailure here? Check Example MVVM
            return UITableViewCell()
        }
        
        cell.fill(with: self.movies[indexPath.row])
        
        return cell
    }
}

extension MoviesHomepageViewController: MoviesHomepageViewModelDelegate {
    func refreshList(with movies: [Movie]) {
        self.movies = movies.compactMap(MoviesListItemViewModel.init)
        self.movieListTableView.reloadData()
    }
}
