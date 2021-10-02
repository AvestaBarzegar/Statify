//
//  Feedback.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-15.
//

import UIKit
import WebKit

class FeedbackViewController: UIViewController {
    
    // MARK: - Interaction Logic
    let headerInfo = SectionHeaderViewModel(title: "Feedback", leftImageName: "xmark.circle.fill", rightImageName: nil)
    
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
        let webView = WKWebView(frame: .zero)
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
        self.view.backgroundColor = UIColor.backgroundComplementColor
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
        let urlString = ClientInfo.surveyURL.rawValue
        guard let urlObj = URL(string: urlString) else { return }
        let request = URLRequest(url: urlObj)
        webView.load(request)
    }
    
    deinit {
        webView.stopLoading()
        webView.removeFromSuperview()
    }

}

extension FeedbackViewController: SectionHeaderViewDelegate {
    
    func didSelectLeftButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didSelectRightButton() {
        return
    }
}

extension FeedbackViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        if url.absoluteString != ClientInfo.surveyURL.rawValue {
            webView.isHidden = true
            self.dismiss(animated: true, completion: nil)
        }

    }
}
