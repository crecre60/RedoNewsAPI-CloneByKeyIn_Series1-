//
//  APICaller.swift
//  RedoNewsAPI
//
//  Created by Young Ju on 5/18/22.
//

import Foundation

struct Constants {
      static let baseURL = "https://newsapi.org"
      static let APIKey = "990dc0cb609a4947bd0339fb364e703f"
}

class APICaller {
      static let shared = APICaller()
      
      func topHeadlines(completion: @escaping (Result<[Article], Error>) -> Void) {
            
            guard let url = URL(string: "\(Constants.baseURL)/v2/top-headlines?country=us&apiKey=\(Constants.APIKey)") else { return }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                  
                  if let error = error {
                        completion(.failure(error))
                        
                        
                  } else if let data = data {
                        
                        do {
                              let result = try JSONDecoder().decode(APIResponse.self, from: data)
                              completion(.success(result.articles))
                        } catch {
                              completion(.failure(error))
                        }
                  }
            }
            task.resume()
      }
      
      func searchNews(query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
            
            guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            guard let url = URL(string: "\(Constants.baseURL)/v2/everything?q=\(query)&apiKey=\(Constants.APIKey)") else { return }
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                  
                  if let error = error {
                        completion(.failure(error))
                  } else if let data = data {
                        do {
                              let result = try JSONDecoder().decode(APIResponse.self, from: data)
                              completion(.success(result.articles))
                        } catch {
                              completion(.failure(error))
                        }
                  }
            }
            task.resume()
      }
}
