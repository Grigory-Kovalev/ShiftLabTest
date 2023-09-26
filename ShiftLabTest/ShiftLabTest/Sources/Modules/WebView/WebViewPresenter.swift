//
//  WebViewPresenter.swift
//  ShiftLabTest
//
//  Created by Григорий Ковалев on 26.09.2023.
//

import Foundation

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
