//
//  MoviesHomepageViewModel.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

// Properties would be in protocol as they are owned by the VM. "Protocol" would take on input/output roles, and then delegate would take on the functions currently used in closures through Actions.
// If error shows up, could have function in VC for showError(_ error: String). At that point, the state of the error is held by the UIView. Other way is just have delegate say an error has appeared, then it would be the VC's task to go to the VM and get the error. Two different approaches. If VM really cares about state, let it own it. If it doesn't care, let the view own it. But be consistent!

protocol MoviesHomepageViewModelProtocol {
    func viewDidLoad() /// Called in the Controller's own viewDidLoad() function.
    func didSearchPopularMovies()
    func didSearchTopRatedMovies()
}

// TODO: Remove once have Observer pattern
protocol MoviesHomepageViewModelDelegate {
    func refreshList(with movies: [Movie])
}

class MoviesHomepageViewModel: MoviesHomepageViewModelProtocol {
    
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCaseProtocol
    private let fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCaseProtocol
    
    // TODO: Remove once have Observer pattern
    private let delegate: MoviesHomepageViewModelDelegate
    
    // MARK: - OUTPUT

     let screenTitle = NSLocalizedString("Movies", comment: "")
    
    // MARK: - Init

    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCaseProtocol,
         fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCaseProtocol, delegate: MoviesHomepageViewModelDelegate) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
        self.fetchTopRatedMoviesUseCase = fetchTopRatedMoviesUseCase
        self.delegate = delegate
    }
        
}

// MARK: - INPUT. View event methods

extension MoviesHomepageViewModel {
    
    func viewDidLoad() { }

    func didSearchPopularMovies() {
        self.fetchPopularMoviesUseCase.start { data in
            print(data?.movies[0] ?? "")
            guard let movies = data?.movies else { return }
            self.delegate.refreshList(with: movies)
        }
    }
    
    func didSearchTopRatedMovies() {
        self.fetchTopRatedMoviesUseCase.start { data in
            print(data?.movies[0] ?? "")
            guard let movies = data?.movies else { return }
            self.delegate.refreshList(with: movies)
        }
    }
}
