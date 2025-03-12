//
//  WebViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/12/25.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Web View"
        navigationController?.navigationBar.prefersLargeTitles = false
        setWebView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - webView에 JavaScript 세팅
    private func setWebView() {
        // JavaScript에서 호출할 핸들러 등록
        let contentController = WKUserContentController()
        contentController.add(self, name: "iosListener")
        contentController.add(self, name: "urlListener")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view.addSubview(webView)

        // HTML 파일 로드
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            let url = URL(fileURLWithPath: htmlPath)
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
}

extension WebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    //MARK: - JavaScript의 alert 처리
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "JavaScript Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler()
        })
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - JavaScript에서 메시지 받았을 때 호출
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        var messageName = message.name
        
        if let messageBody = message.body as? String {
            switch messageName {
            // Swift에서 JavaScript 함수 호출
            case "iosListener":
                print("JavaScript에서 받은 메시지: \(messageBody)")
                let jsCode = "showMessageFromSwift('Hello from Swift!')"
                webView.evaluateJavaScript(jsCode) { (result, error) in
                    if let error = error {
                        print("JavaScript 실행 오류: \(error.localizedDescription)")
                    } else {
                        print("JavaScript 실행 성공: \(String(describing: result))")
                    }
                }
            // JavaScript에서 URL을 받아 WebView 이동
            case "urlListener":
                print("JavaScript에서 받은 URL: \(messageBody)")
                
                if let url = URL(string: messageBody) {
                    let request = URLRequest(url: url)
                    webView.load(request)
                }
            default: break
            }
        }
    }
}
