//
//  MealDetailViewController.swift
//  MealsApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import WebKit

class MealDetailViewController: UIViewController {

    @IBOutlet private weak var mealNameLabel: UILabel!
    
    @IBOutlet private weak var mealInstructionsTextView: UITextView!
    
    @IBOutlet private weak var mealsIngredientsTableView: UITableView!
    
    @IBOutlet private weak var webView: WKWebView!
    
    var viewModel: MealDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureNavigationBar() {
        self.title = "Meal Detail"
     }
    
    func configureUI() {
        configureNavigationBar()
        configureNameLabel()
        configureTextView()
        configureTableView()
        configureWebKit()
    }
    
    private func configureTextView() {
        self.mealInstructionsTextView.text = viewModel?.getInstructions
    }
    
    private func configureNameLabel() {
        self.mealNameLabel.text = viewModel?.getName
        self.mealNameLabel.font = .systemFont(ofSize: 30, weight: .regular)
        self.mealNameLabel.numberOfLines = 0
        self.mealNameLabel.textAlignment = .center
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "MealIngredientsTableViewCell", bundle: nil)
        self.mealsIngredientsTableView.register(nib, forCellReuseIdentifier: "MealIngredientsTableViewCell")
        self.mealsIngredientsTableView.dataSource = self
        self.mealsIngredientsTableView.allowsSelection = false
        self.mealsIngredientsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func configureWebKit() {
        guard let link = viewModel?.getYoutubeLink else {
            return
        }
        self.webView.load(.init(url: link))
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

extension MealDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getIngredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealIngredientsTableViewCell") as? MealIngredientsTableViewCell,
            let ingredient = viewModel?.getIngredients[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(ingredient)
        return cell
    }
    
}
