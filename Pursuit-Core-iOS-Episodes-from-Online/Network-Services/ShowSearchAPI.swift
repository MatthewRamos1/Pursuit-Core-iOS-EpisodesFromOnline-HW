//
//  ShowSearchAPI.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Matthew Ramos on 12/15/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowSearchAPI {
    
    static func fetchShows (searchQuery: String, completion: @escaping (Result<[Show],AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "girls"
        let showEndPointURL = "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        guard let url = URL(string: showEndPointURL) else {
            completion(.failure(.badURL(showEndPointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode([ShowData].self, from: data)
                    let shows = searchResults.map { $0.show }
                    completion(.success(shows))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func fetchEpisodes (show: Show, completion: @escaping
      (Result<[Episode],AppError>) -> ()) {
        
        let show = String(show.id)
        let episodesEndPointURL = "https://api.tvmaze.com/shows/\(show)/episodes"
        
        guard let url = URL(string: episodesEndPointURL) else {
            completion(.failure(.badURL(episodesEndPointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let episodeResults = try JSONDecoder().decode([Episode].self, from: data)
                    completion(.success(episodeResults))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
