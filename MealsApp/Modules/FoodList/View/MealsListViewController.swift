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
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @objc private func renewBanner() {
        viewModel?.getRandomMeal(completion: { [weak self] (response) in
            switch response {
            case .success(let url):
                self?.bannerImageView.image(fromUrl: url)
            case .failure(_):
                break
            }
        })
    }
    
    var viewModel: MealListViewModel?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MealListViewModelAdapter()
        configureUI()
    }
    
    private func configureUI() {
        configureNavigationBar()
        configureSearchBar()
        configureTableView()
        configureBannerImageView()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Meals List"
    }
    
    private func configureBannerImageView() {
        bannerImageView.contentMode = .scaleAspectFill
        timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(renewBanner), userInfo: nil, repeats: true)
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.addDoneButtonOnKeyboard()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MealTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.tableFooterView = UIView(frame: .zero)
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
            let viewModel = self.viewModel,
            indexPath.row < viewModel.mealsList.count else {
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
        viewModel?.getMealsSearch(using: text, completion: { [weak self] (response) in
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
