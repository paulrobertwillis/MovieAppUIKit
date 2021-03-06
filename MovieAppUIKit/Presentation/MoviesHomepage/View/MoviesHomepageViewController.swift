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
    
    // MARK: - Public Properties
    
    var posterImageRepository: PosterImageRepositoryProtocol?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appConfiguration = AppConfiguration()
        let config = APIDataNetworkConfig(baseURL: appConfiguration.imagesBaseURL)
        let sessionManager = NetworkSessionManager()
        let networkService = NetworkService(config: config, sessionManager: sessionManager)
        let imageDataTransferService = DataTransferService(with: networkService)
        self.posterImageRepository = PosterImageRepository(dataTransferService: imageDataTransferService)
        
        let network = MoviesNetworkService()
        let service = MoviesService(network: network)
        let repository = MoviesRepository(service)
        let popularUseCase = FetchPopularMoviesUseCase(moviesRepository: repository)
        let topRatedUseCase = FetchTopRatedMoviesUseCase(moviesRepository: repository)
        self.viewModel = MoviesHomepageViewModel(fetchPopularMoviesUseCase: popularUseCase, fetchTopRatedMoviesUseCase: topRatedUseCase, delegate: self)
        
        self.setUpViews()
        self.setUpTableView()
    }
    
    // MARK: - Private
    
    private func setUpViews() {
        self.title = viewModel.screenTitle
    }
    
    private func setUpTableView() {
        self.movieListTableView.dataSource = self
        
        
        let cellNib = UINib(nibName: MoviesListItemCell.reuseIdentifier, bundle: nil)
        self.movieListTableView.register(cellNib, forCellReuseIdentifier: MoviesListItemCell.reuseIdentifier)
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
        return self.viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = MoviesListItemCell.reuseIdentifier
                
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesListItemCell.reuseIdentifier,
                                                                     for: indexPath) as? MoviesListItemCell
        else {
            // TODO: assertionFailure here? Check Example MVVM
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell.fill(
            with: self.viewModel.movies[indexPath.row],
            posterImageRepository: self.posterImageRepository
        )
        
        return cell
    }
}

extension MoviesHomepageViewController: MoviesHomepageViewModelDelegate {
    func refreshList() {
        self.movieListTableView.reloadData()
    }
}
