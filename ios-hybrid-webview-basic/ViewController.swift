//
//  ViewController.swift
//  ios-hybrid-webview-basic
//
//  Created by David on 2022/11/29.
//

import UIKit
import WebKit

struct MESSAGE_NAME {
    static let navigateTo = "navigateTo"
}

class ViewController: UIViewController {
    
    var webView: WKWebView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureWebView()
    }
    
    private func configureWebView(){
        guard let url = URL(string: "https://naver.com")  else { fatalError("there is no url") }
        
        let config = WKWebViewConfiguration()
        let userController = WKUserContentController()
        userController.add(self, name: "navigateTo")
        userController.add(self, name: "appLogout")
        
        config.userContentController = userController

        self.webView = WKWebView(frame: self.view.frame,
               configuration: config)
        
        guard let webView = self.webView else { return }
        
        let urlRequest = URLRequest(url: url)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(urlRequest)
        
        self.view.addSubview(webView)
        
    }

}

extension ViewController: WKUIDelegate {
    
}

extension ViewController: WKNavigationDelegate {
    
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        let messageName = message.name
        
        if let messageBody = message.body as? Dictionary<String, Any> {
            guard let password = messageBody["aa"] as? String else { return }
        }
        
        if messageName == MESSAGE_NAME.navigateTo {
            
            return
        }
        
    }
}
