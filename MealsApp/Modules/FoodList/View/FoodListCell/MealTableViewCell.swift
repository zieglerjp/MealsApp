//
//  MealTableViewCell.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var mealImageView: UIImageView!
    
    @IBOutlet private weak var mealCategoryLabel: UILabel!
    
    @IBOutlet private weak var mealNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(viewModel: MealCellViewModel) {
        self.mealNameLabel.text = viewModel.getName
        
        self.mealNameLabel.font = .systemFont(ofSize: 20, weight: .regular)
        self.mealNameLabel.numberOfLines = 0
        self.mealCategoryLabel.text = viewModel.getCategory
        
        self.mealNameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        guard let image = viewModel.getImage else {
            return
        }
        self.mealImageView.image(fromUrl: image)
    }
    
}
