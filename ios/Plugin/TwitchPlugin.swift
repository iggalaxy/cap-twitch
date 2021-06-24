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

//class StreamViewController: SFSafariViewController, WKUIDelegate {
//
//
////    var webView: SFSafari
////
////    override func loadView() {
////        let webConfiguration = WKWebViewConfiguration()
////
////        webView = WKWebView(frame: .zero, configuration: webConfiguration)
////        webView.uiDelegate = self
////        view = webView
////    }
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        let myURL = URL(string: "https://player.twitch.tv/?channel=uhSnow&parent=www.iggalaxy.com")
////        let myRequest = URLRequest(url: myURL!)
////        webView.load(myRequest)
////    }
////
////    override func viewDidAppear(_ animated: Bool) {
////        webView.top = 100
//////        webView.bottom = 30
////        webView.left = 20
//////        webView.right = 20
////        webView.width = 400
////        webView.height = 300
////    }
//}
class StreamViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    var loadedUrl: String = ""

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
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

//    override func viewDidAppear(_ animated: Bool) {
//        webView.top = 100
////        webView.bottom = 30
//        webView.left = 20
////        webView.right = 20
//        webView.width = 400
//        webView.height = 300
//    }
}


/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(TwitchPlugin)
public class TwitchPlugin: CAPPlugin {
    private let implementation = Twitch()
    
//    let streamView = StreamViewController.init(url: URL(string: "https://staging.igg.network")!)
    let streamView = StreamViewController()


    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""

//
//        let alertController = UIAlertController(title: "Test", message: value, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
//        let webConfig = WKWebViewConfiguration()
//        let webView = WKWebView(frame: .zero, configuration: webConfig)
//
//        webView.load(URLRequest(url: URL(string: "https://staging.igg.network")!))
//        streamView.loadViewIfNeeded()
        
        
        DispatchQueue.main.async {
            
            self.streamView.loadUrl(url: "https://player.twitch.tv/?channel=" + value + "&parent=www.iggalaxy.com")
            
//            let vc = self.bridge?.viewController
//
//            vc!.addChild(self.streamView)
//            vc!.view.addSubview(self.streamView.view)
//            self.streamView.didMove(toParent: vc)
            
            
            self.bridge?.viewController!.present(self.streamView, animated: true)
            
//            self.bridge?.viewController!.addChild(webView);
//            self.bridge?.viewController!.add(StreamViewController())
//            self.bridge?.viewController!.addChild(streamView)
//            self.bridge?.viewController!.view.addSubview(streamView.view)
//            streamView.didMove(toParent: self.bridge?.viewController!)
        }

//        call.resolve([
//            "value": implementation.echo(value)
//        ])

//         let message = call.getString("message") ?? ""
//         let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
// ​
//         alertController.addAction(UIAlertAction(title: "Ok", style: .default))
// ​
//         DispatchQueue.main.async {
//           self.bridge.viewController.present(alertController, animated: true, completion: nil)
//         }

//         call.resolve();
    }
}
