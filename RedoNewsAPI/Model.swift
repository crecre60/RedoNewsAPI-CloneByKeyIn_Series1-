//
//  Model.swift
//  RedoNewsAPI
//
//  Created by Young Ju on 5/18/22.
//

import Foundation

struct APIResponse: Codable {
      let articles: [Article]
}

struct Article: Codable {
      let title: String
      let url: String
      let urlToImage: String?
      let description: String?
}
