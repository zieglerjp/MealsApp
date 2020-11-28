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
        title = "Meal Detail"
     }
    
    func configureUI() {
        configureNavigationBar()
        configureNameLabel()
        configureTextView()
        configureTableView()
        configureWebKit()
    }
    
    private func configureTextView() {
        mealInstructionsTextView.text = viewModel?.getInstructions
    }
    
    private func configureNameLabel() {
        mealNameLabel.text = viewModel?.getName
        mealNameLabel.font = .systemFont(ofSize: 30, weight: .regular)
        mealNameLabel.numberOfLines = 0
        mealNameLabel.textAlignment = .center
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "MealIngredientsTableViewCell", bundle: nil)
        mealsIngredientsTableView.register(nib, forCellReuseIdentifier: "MealIngredientsTableViewCell")
        mealsIngredientsTableView.dataSource = self
        mealsIngredientsTableView.allowsSelection = false
        mealsIngredientsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func configureWebKit() {
        guard let link = viewModel?.getYoutubeLink else {
            return
        }
        webView.load(.init(url: link))
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
        return viewModel?.getIngredients.count ?? 0
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
