//
//  MoviesListItemCell.swift
//  MovieAppUIKit
//
//  Created by Paul on 25/02/2022.
//

import UIKit

public class MoviesListItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MoviesListItemCell.self)
    static let height = CGFloat(130)
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    private var viewModel: MoviesListItemViewModel!
    private var posterImageRepository: PosterImageRepositoryProtocol?
    
    func fill(with viewModel: MoviesListItemViewModel, posterImageRepository: PosterImageRepositoryProtocol?) {
        self.viewModel = viewModel
        self.posterImageRepository = posterImageRepository
        
        self.titleLabel.text = self.viewModel.title
        self.dateLabel.text = self.viewModel.releaseDate
        self.updatePosterImage(width: Int(self.posterImageView.frame.width))
    }
    
    func updatePosterImage(width: Int) {
        self.posterImageView.image = nil
        guard let posterImagePath = self.viewModel.posterImagePath else { return }
        
        self.posterImageRepository?.fetchImage(with: posterImagePath, width: width) { [weak self] result in
            guard let self = self else { return }

//            if case let .success(data) = result {
//                self.posterImageView.image = UIImage(data: data)
//            }
            
            switch result {
            case .success(let data):
                self.posterImageView.image = UIImage(data: data)
            case .failure(let error):
                print("Error in downloading poster image: \(error)")
            }
        }
    }
}
