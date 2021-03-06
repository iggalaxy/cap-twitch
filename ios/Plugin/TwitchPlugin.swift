import Foundation
import Capacitor

import UIKit
import WebKit
import SafariServices

extension UIView {
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue - self.frame.size.height
            self.frame = rect
        }
    }
    
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue - self.frame.size.width
            self.frame = rect
        }
    }
}

class StreamViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    var loadedUrl: String = ""

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.isOpaque = false
        webView.backgroundColor = .black
        
        webView.uiDelegate = self
        view = webView
    }
    
    func loadUrl(url: String) {
        if (self.webView == nil) {
            // load the view if not already setup
            self.loadView()
        }
        
        if (self.loadedUrl == url) {
            // dont reload the same page
            return;
        }
        
        let myURL = URL(string: url)
        if (myURL == nil) {
            // TODO: return error loading??
            return
        }
        let myRequest = URLRequest(url: myURL!)
        
        self.webView.load(myRequest)
        
        self.loadedUrl = url
    }
}

@objc(TwitchPlugin)
public class TwitchPlugin: CAPPlugin {
    private let implementation = Twitch()
    
    let streamView = StreamViewController()


    @objc func openStream(_ call: CAPPluginCall) {
        let username = call.getString("username") ?? ""
        
        DispatchQueue.main.async {
            self.streamView.loadUrl(url: "https://player.twitch.tv/?channel=" + username + "&parent=www.iggalaxy.com")
            self.bridge?.viewController!.present(self.streamView, animated: true)
        }
    }
}
