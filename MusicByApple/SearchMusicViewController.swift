//
//  SearchViewController.swift
//  MusicByApple
//
//  Created by lion on 10.06.22.
//

import UIKit
import Alamofire



class SearchMusicViewController: UITableViewController {
    
    var networkService = NetworkService()
    
    private var tracks = [Track]()
    let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = UIImage(systemName: "square.grid.3x1.below.line.grid.1x2")
        return cell
    }
}

extension SearchMusicViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.networkService.fetchTracks(searchText: searchText, completion: { [weak self] searchResults in
                self?.tracks = searchResults?.results ?? [Track(artistName: "none", trackName: "none")]
                self?.tableView.reloadData()
            })
        })
    }
}
