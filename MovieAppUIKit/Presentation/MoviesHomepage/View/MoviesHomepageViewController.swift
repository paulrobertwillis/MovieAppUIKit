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
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let network = DefaultNetworkService()
        let service = DefaultMoviesService(network: network)
        let repository = DefaultMoviesRepository(service)
        let useCase = DefaultFetchPopularMoviesUseCase(moviesRepository: repository)
        self.viewModel = DefaultMoviesHomepageViewModel(fetchPopularMoviesUseCase: useCase)
        
        self.setupViews()

    }
    
    
    // MARK: - Private
    
    private func setupViews() {
        self.title = viewModel.screenTitle
    }
    
    // MARK: - IBActions
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        print("Search button tapped")
        print(searchTextField.text!)
    }
    
    @IBAction func popularButtonTapped(_ sender: Any) {
        print("Popular button tapped")
        self.viewModel.didSearchPopularMovies()
    }
    
    @IBAction func topRatedButtonTapped(_ sender: Any) {
        print("Top Rated button tapped")
        self.viewModel.didSearchTopRatedMovies()
    }


    // MARK: - Helpers

    
    
}

