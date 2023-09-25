//
//  WebView.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 25.09.2023.
//

protocol WebViewPresenterProtocol {
    func closeWebView()
}

final class WebViewPresenter {
    weak var viewController: WebViewControllerProtocol?
    weak var coordinator: CoordinatorProtocol?
}

extension WebViewPresenter: WebViewPresenterProtocol {
    func closeWebView() {
        self.coordinator?.closeModule()
    }
}

protocol WebViewAssemblyProtocol {
    func createModule() -> UIViewController
}

final class WebViewAssembly: WebViewAssemblyProtocol {
    var url: URL!
    init(url: URL) {
        self.url = url
    }
    
    func createModule() -> UIViewController {
        let viewController = WebViewController()
        viewController.website = url
        let navVC = UINavigationController(rootViewController: viewController)
        let presenter = WebViewPresenter()
        let coordinator = Coordinator.share
        
        // Установка зависимостей
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.coordinator = coordinator
        
        
        return navVC
    }

}


import UIKit
import WebKit

protocol WebViewControllerProtocol: AnyObject {
}

final class WebViewController: UIViewController {
    
    var presenter: WebViewPresenterProtocol?
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var website: URL?
    
    override func loadView() {
        configureWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureToolBarItems()
        loadInitialWebsite()
        showProgress()
    }
    
    @objc private func closeTapped() {
        self.presenter?.closeWebView()
    }
}

//MARK: - UI

private extension WebViewController {
    func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeTapped))
    }
    
    private func configureToolBarItems() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [spacer, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
}

//MARK: - WebView
private extension WebViewController {
    func configureWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    func loadInitialWebsite() {
        guard let website else { return }
        webView.load(URLRequest(url: website))
        webView.allowsBackForwardNavigationGestures = true
    }
}

//MARK: - Observer

extension WebViewController {
    func showProgress() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

//MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    
    //загрузка сайта закончилась
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

extension WebViewController: WebViewControllerProtocol {
    
}
