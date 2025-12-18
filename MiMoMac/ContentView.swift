//
//  ContentView.swift
//  MiMoMac
//
//  主视图 - WebView嵌入MiMo Studio
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var isLoading = true
    @State private var loadProgress: Double = 0
    @State private var canGoBack = false
    @State private var canGoForward = false
    @State private var currentURL = "https://aistudio.xiaomimimo.com"
    
    var body: some View {
        VStack(spacing: 0) {
            // 工具栏
            HStack(spacing: 12) {
                // 导航按钮
                HStack(spacing: 4) {
                    Button(action: { NotificationCenter.default.post(name: .goBack, object: nil) }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .buttonStyle(.borderless)
                    .disabled(!canGoBack)
                    
                    Button(action: { NotificationCenter.default.post(name: .goForward, object: nil) }) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .buttonStyle(.borderless)
                    .disabled(!canGoForward)
                    
                    Button(action: { NotificationCenter.default.post(name: .reload, object: nil) }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .buttonStyle(.borderless)
                }
                
                // 地址栏
                HStack {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(.green)
                    
                    Text("aistudio.xiaomimimo.com")
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 6))
                
                Spacer()
                
                // 标题
                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .foregroundStyle(.orange)
                    Text("MiMo AI")
                        .font(.headline)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            
            // 加载进度条
            if isLoading {
                ProgressView(value: loadProgress)
                    .progressViewStyle(.linear)
                    .tint(.orange)
            }
            
            // WebView
            MiMoWebView(
                isLoading: $isLoading,
                loadProgress: $loadProgress,
                canGoBack: $canGoBack,
                canGoForward: $canGoForward
            )
        }
    }
}

// MARK: - macOS WebView

struct MiMoWebView: NSViewRepresentable {
    @Binding var isLoading: Bool
    @Binding var loadProgress: Double
    @Binding var canGoBack: Bool
    @Binding var canGoForward: Bool
    
    let url = URL(string: "https://aistudio.xiaomimimo.com")!
    
    func makeNSView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.preferences.isElementFullscreenEnabled = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        
        // 监听加载进度
        webView.addObserver(context.coordinator, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: "canGoBack", options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: "canGoForward", options: .new, context: nil)
        
        // 监听导航通知
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(Coordinator.goBack), name: .goBack, object: nil)
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(Coordinator.goForward), name: .goForward, object: nil)
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(Coordinator.reload), name: .reload, object: nil)
        
        context.coordinator.webView = webView
        
        // 加载网页
        let request = URLRequest(url: url)
        webView.load(request)
        
        return webView
    }
    
    func updateNSView(_ webView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: MiMoWebView
        weak var webView: WKWebView?
        
        init(_ parent: MiMoWebView) {
            self.parent = parent
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            guard let webView = object as? WKWebView else { return }
            
            DispatchQueue.main.async {
                if keyPath == "estimatedProgress" {
                    self.parent.loadProgress = webView.estimatedProgress
                } else if keyPath == "canGoBack" {
                    self.parent.canGoBack = webView.canGoBack
                } else if keyPath == "canGoForward" {
                    self.parent.canGoForward = webView.canGoForward
                }
            }
        }
        
        @objc func goBack() { webView?.goBack() }
        @objc func goForward() { webView?.goForward() }
        @objc func reload() { webView?.reload() }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async { self.parent.isLoading = true }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async { self.parent.isLoading = false }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async { self.parent.isLoading = false }
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            decisionHandler(.allow)
        }
    }
}

// MARK: - 通知

extension Notification.Name {
    static let goBack = Notification.Name("goBack")
    static let goForward = Notification.Name("goForward")
    static let reload = Notification.Name("reload")
}

#Preview {
    ContentView()
        .frame(width: 1000, height: 700)
}
