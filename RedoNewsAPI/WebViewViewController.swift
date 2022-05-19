      //
      //  WebViewViewController.swift
      //  RedoNewsAPI
      //
      //  Created by Young Ju on 5/18/22.
      //

import UIKit
import WebKit

class WebViewViewController: UIViewController {
      
      let webView: WKWebView = {
            let webView = WKWebView()
            webView.translatesAutoresizingMaskIntoConstraints = false
            return webView
      }()
      
      override func viewDidLoad() {
            super.viewDidLoad()
            
            view.addSubview(webView)
      }
      
      override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            webView.frame = view.bounds
      }
      
      
      
      
}
