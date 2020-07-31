//
//  MealDetailViewController.swift
//  MealsApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class MealDetailViewController: UIViewController {

    @IBOutlet weak var mealNameLabel: UILabel!
    
    @IBOutlet weak var mealInstructionsTextView: UITextView!
    
    @IBOutlet weak var mealsIngredientsTableView: UITableView!
    
    var viewModel: MealDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureNavigationBar() {
         self.navigationItem.title = "Meal Detail"
     }
    
    func configureUI() {
        self.mealNameLabel.text = viewModel?.getName
        self.mealNameLabel.font = .systemFont(ofSize: 30, weight: .regular)
        self.mealInstructionsTextView.text = viewModel?.getInstructions
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
