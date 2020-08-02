//
//  MealIngredientsTableViewCell.swift
//  MealsApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class MealIngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var mealIngredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func configure(_ ingredient: String) {
        mealIngredientLabel.font = .systemFont(ofSize: 14, weight: .regular)
        mealIngredientLabel.text = ingredient
        mealIngredientLabel.numberOfLines = 0
    }
}
