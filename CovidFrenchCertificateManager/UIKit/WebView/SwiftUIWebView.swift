//
//  SwiftUIWebView.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

struct SwiftUIWebView: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    
    let webView = WKWebView()
   
    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.link) {
            self.webView.load(URLRequest(url: url))
        }
        return self.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SwiftUIWebView>) {
        return
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        
        private func injectValues(webView : WKWebView) -> Void {
            // self.viewModel.people.
            var jsRequest = String()
            
            jsRequest += "document.getElementById('field-firstname').value=\"\(String(describing: self.viewModel.people.firstname ?? "--"))\";"
            jsRequest += "document.getElementById('field-lastname').value=\"\(String(describing: self.viewModel.people.lastname ?? "--"))\";"
            jsRequest += "document.getElementById('field-birthday').value=\"\(String(describing: self.viewModel.people.bornDate ?? "--"))\";"
            
            jsRequest += "document.getElementById('field-lieunaissance').value=\"\(String(describing: self.viewModel.people.bornCity ?? "--"))\";"
            
            jsRequest += "document.getElementById('field-address').value=\"\(String(describing: self.viewModel.people.adress ?? "--"))\";"
            jsRequest += "document.getElementById('field-town').value=\"\(String(describing: self.viewModel.people.city ?? "--"))\";"
            
            jsRequest += "document.getElementById('field-zipcode').value=\"\(String(describing: self.viewModel.people.zip ?? "--"))\";"
            
            for reason in self.viewModel.reasons {
                if reason.isSelected {
                    jsRequest += "document.getElementById(\"checkbox-\(reason.code)\").checked = true;"
                }
            }
            
            jsRequest += "document.querySelector(\".btn-attestation\").click();"
            
            webView.evaluateJavaScript(jsRequest) { (result, error) in
                if let result = result {
                    print(result)
                }
            }
        }
        
        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("WebView: navigation finished")
           // self.viewModel.didFinishLoading = true
            if (webView.url?.absoluteString ?? "").starts(with: "blob") {
                self.viewModel.didFinishLoading = true
            }
            self.injectValues(webView: webView)
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            self.viewModel.didFinishLoading = false
            
            decisionHandler(.allow)
        }
    }
    
    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        Coordinator(viewModel)
    }
}
