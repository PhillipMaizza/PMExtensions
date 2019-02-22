//
//  WKWebViewExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation
import WebKit

public extension WKWebView {
	
	/// Shows an embed YouTube video
	public func show(youtubeVideoWithId id: String) {
		if let urlns = URL(string: "https://www.youtube.com/embed/\(id)?modestbranding=1&rel=0&showinfo=0&theme=light") {
			let request = URLRequest(url: urlns)
			self.load(request)
		}
	}
}
