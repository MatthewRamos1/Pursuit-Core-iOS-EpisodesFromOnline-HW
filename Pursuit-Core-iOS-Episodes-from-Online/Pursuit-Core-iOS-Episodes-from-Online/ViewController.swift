//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchShows(searchQuery: "girls")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    func searchShows(searchQuery: String) {
        ShowSearchAPI.fetchShow(searchQuery: searchQuery, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error: Could not read data", message: "\(appError)")
                }
            case .success(let shows):
                DispatchQueue.main.async {
                    self?.shows = shows
                }
            }
            
        })
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shows.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowCell else {
            fatalError("Error: Couldn't pull ShowCell")
        }
        let show = shows[indexPath.row]
        cell.configureCell(show: show)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 236
    }
}

extension ViewController: UISearchBarDelegate {
    
}
