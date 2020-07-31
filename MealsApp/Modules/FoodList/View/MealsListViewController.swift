//
//  MealsListViewController.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class MealsListViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MealListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        viewModel = MealListViewModelAdapter()
    }
    
    private func configureUI() {
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Meals List"
    }
    
    private func configureSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.searchTextField.addDoneButtonOnKeyboard()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "MealTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = true
        self.tableView.tableFooterView = UIView(frame: .zero)
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

extension MealsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.mealsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell") as? MealTableViewCell,
        let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel: MealCellViewModelAdapter(viewModel.mealsList[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let meal = viewModel?.mealsList[indexPath.row] else {
            return
        }
        guard let viewController = UIStoryboard(
            name: "MealDetailViewController", bundle: nil
        ).instantiateViewController(withIdentifier: "MealDetailViewController") as? MealDetailViewController else {
            return
        }
        viewController.viewModel = MealDetailViewModelAdapter(meal)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MealsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else {
              return
          }
        self.viewModel?.getMealsSearch(using: text, completion: { [weak self] (response) in
            switch response {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .empty:
                break
            case .failure(_):
                break
            }
        })
    }
}
