//
//  MoviesHomepageViewModel.swift
//  MovieAppUIKit
//
//  Created by Paul on 24/02/2022.
//

import Foundation

struct MoviesHomepageViewModelActions {
    // Actions that can be taken by the ViewModel on behalf of a Controller.
    // These should begin with imperative verbs: Show, Hide, Close, Open, etc, and be constants of type closure.
    // Used to tell a Controller (or a FlowCoordinator) when to present another view.
    
    // EXAMPLE:
    // let showMovieDetails: (Movie) -> Void
}

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

final class DefaultMoviesHomepageViewModel: MoviesHomepageViewModel {
    
    // UseCases should be defined through protocols. E.g., SearchMovieUseCase would be a protocol implemented by DefaultSearchMoviesUseCase.
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
    private let actions: MoviesHomepageViewModelActions?
    
    // MARK: - OUTPUT

    // EXAMPLE:
    // let query: Observable<String> = Observable("")
     let screenTitle = NSLocalizedString("Movies", comment: "")
    
    // MARK: - Init

    init(fetchPopularMoviesUseCase: FetchPopularMoviesUseCase,
         actions: MoviesHomepageViewModelActions? = nil) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
        self.actions = actions
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
        print("inside didSearchPopularMovies")
        self.fetchPopularMoviesUseCase.start { data in
            print(data)
            // TODO: Do something with the data (which is a MoviesPage) to refresh the table
        }
    }
    
    func didSearchTopRatedMovies() {
        
    }
}
