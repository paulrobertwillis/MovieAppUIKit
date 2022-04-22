//
//  MoviesHomepageViewModel.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

// Properties would be in protocol as they are owned by the VM. "Protocol" would take on input/output roles, and then delegate would take on the functions currently used in closures through Actions.
// If error shows up, could have function in VC for showError(_ error: String). At that point, the state of the error is held by the UIView. Other way is just have delegate say an error has appeared, then it would be the VC's task to go to the VM and get the error. Two different approaches. If VM really cares about state, let it own it. If it doesn't care, let the view own it. But be consistent!

protocol MoviesHomepageViewModelInput {
    // Used to make the View Model testable by allowing it to be mocked.
    
    // Functions called by the ViewModel's Controller.
    
    // EXAMPLE:
    func viewDidLoad() /// Called in the Controller's own viewDidLoad() function.
    func didSearchPopularMovies()
    func didSearchTopRatedMovies()

    // func didLoadNextPage()
    // func didSearch(query: String)
}

protocol MoviesHomepageViewModelOutput {
    // Used to make the View Model testable by allowing it to be mocked.
    
    // Variables outputted by the ViewModel to its Controller.
    
    // EXAMPLE:
    // var query: Observable<String> { get }
     var screenTitle: String { get }
}

protocol MoviesHomepageViewModel: MoviesHomepageViewModelInput, MoviesHomepageViewModelOutput {}

// TODO: Remove once have Observer pattern
protocol MoviesHomepageViewModelDelegate {
    func refreshList(with movies: [Movie])
}

final class DefaultMoviesHomepageViewModel: MoviesHomepageViewModel {
    
    // UseCases should be defined through protocols. E.g., SearchMovieUseCase would be a protocol implemented by DefaultSearchMoviesUseCase.
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCaseProtocol
    private let fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase
    
    // TODO: Remove once have Observer pattern
    private let delegate: MoviesHomepageViewModelDelegate
    
    // MARK: - OUTPUT

    // EXAMPLE:
    // let query: Observable<String> = Observable("")
     let screenTitle = NSLocalizedString("Movies", comment: "")
    
    // MARK: - Init

    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCaseProtocol,
         fetchTopRatedMoviesUseCase: FetchTopRatedMoviesUseCase, delegate: MoviesHomepageViewModelDelegate) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
        self.fetchTopRatedMoviesUseCase = fetchTopRatedMoviesUseCase
        self.delegate = delegate
    }

    
    // MARK: - Private
        
}

// MARK: - INPUT. View event methods

extension DefaultMoviesHomepageViewModel {
    
    func viewDidLoad() { }

    // EXAMPLE:
    // func didLoadNextPage() {
    //     guard hasMorePages, loading.value == .none else { return }
    //     load(movieQuery: .init(query: query.value),
    //          loading: .nextPage)
    // }
    //
    // func didSearch(query: String) {
    //     guard !query.isEmpty else { return }
    //     update(movieQuery: MovieQuery(query: query))
    // }

    func didSearchPopularMovies() {
        self.fetchPopularMoviesUseCase.start { data in
            print(data?.movies[0])
            
            guard let movies = data?.movies else { return }
            
            self.delegate.refreshList(with: movies)
        }
    }
    
    func didSearchTopRatedMovies() {
        self.fetchTopRatedMoviesUseCase.start { data in
            print(data?.movies[0])
            
            guard let movies = data?.movies else { return }
            
            self.delegate.refreshList(with: movies)

        }
    }
}
