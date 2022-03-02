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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var viewModel: MoviesListItemViewModel!
    
    func fill(with viewModel: MoviesListItemViewModel) {
        self.viewModel = viewModel
        
        self.titleLabel.text = self.viewModel.title
        self.dateLabel.text = self.viewModel.releaseDate
    }
}
