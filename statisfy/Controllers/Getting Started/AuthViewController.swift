//
//  AuthViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    // MARK: - Interaction Logic
    let headerInfo = SectionHeaderViewModel(title: "Login", leftImageName: "xmark.circle.fill", rightImageName: nil)
    
    public var completionHandler: ((Bool) -> Void)?
    
    // MARK: - Init Views
    
    private lazy var headerView: SectionHeaderView = {
        let header = SectionHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.info = headerInfo
        header.delegate = self
        return header
    }()
    
    private let webView: WKWebView = {
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        
        let webView = WKWebView(frame: .zero,
                                configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
        
    }()
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadWebView()
    }
    
    private func setup() {
        self.view.backgroundColor = .spotifyGray
        let safeArea = self.view.layoutMarginsGuide
        self.view.addSubview(headerView)
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight.rawValue),
            
            webView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func loadWebView() {
        guard let url = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: url))
    }

}

extension AuthViewController: SectionHeaderViewDelegate {
    
    func leftButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func rightButtonClicked() {
        return
    }
}

extension AuthViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        // Exchange code for access token
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        
        print("code: \(code)")
        TokenManager.shared.exchangeCodeForToken(code: code, completion: { _ in 
            
        })
        
    }
}
