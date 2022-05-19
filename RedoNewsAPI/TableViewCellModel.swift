//
//  TableViewCellModel.swift
//  RedoNewsAPI
//
//  Created by Young Ju on 5/18/22.
//

import Foundation

class TableViewCellModel {
      let title: String
      let subtitle: String
      let imageURL: URL?
      var imageData: Data? = nil
      
      init(titleInit: String, subtitleInit: String, imageURIInit: URL?){
            self.title = titleInit
            self.subtitle = subtitleInit
            self.imageURL = imageURIInit
      }
}
