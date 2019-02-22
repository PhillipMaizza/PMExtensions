//
//  UIImageExtensions.swift
//  PMExtensions
//
//  Created by Phillip Maizza on 22/02/2019.
//  Copyright © 2019 Phillip Maizza. All rights reserved.
//

import Foundation

public extension UIImage {

	/// Returns an image with the specified color
	public class func with(color: UIColor) -> UIImage {
		let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
		UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
		color.setFill()
		UIRectFill(rect)
		let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}

	/// Returns a new image resized to the specified width and height
	func resized(to newWidth: CGFloat) -> UIImage {
		let scale = newWidth / self.size.width
		let newHeight = self.size.height * scale
		UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, UIScreen.main.scale)
		self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
		if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
			UIGraphicsEndImageContext()
			return newImage
		} else {
			return self
		}
	}

	/// Returns the size of the image in bytes
	public var bytesSize: Int {
		return self.jpegData(compressionQuality: 1)?.count ?? 0
	}

	/// Returns the size of the image in kilobytes
	public var kilobytesSize: Int {
		return bytesSize / 1024
	}

	/// Returns the original image
	public var original: UIImage {
		return withRenderingMode(.alwaysOriginal)
	}

	/// Returns the image as template
	public var template: UIImage {
		return withRenderingMode(.alwaysTemplate)
	}

	/// Returns the compressed image based on the quality parameter (defaults to 0.5)
	public func compressed(quality: CGFloat = 0.5) -> UIImage? {
		guard let data = compressedData(quality: quality) else { return nil }
		return UIImage(data: data)
	}

	/// Returns the compressed data based on the quality parameter (defaults to 0.5)
	public func compressedData(quality: CGFloat = 0.5) -> Data? {
		return self.jpegData(compressionQuality: quality)
	}

	/// Returns a cropped image resized to the specified rect
	public func cropped(to rect: CGRect) -> UIImage {
		guard rect.size.height < size.height && rect.size.height < size.height else { return self }
		guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
		return UIImage(cgImage: image)
	}

	/// UIImage scaled to height with respect to aspect ratio.
	///
	/// - Parameters:
	///   - toHeight: new height.
	///   - opaque: flag indicating whether the bitmap is opaque.
	///   - orientation: optional UIImage orientation (default is nil).
	/// - Returns: optional scaled UIImage (if applicable).
	public func scaled(toHeight: CGFloat, opaque: Bool = false, with orientation: UIImage.Orientation? = nil) -> UIImage? {
		let scale = toHeight / size.height
		let newWidth = size.width * scale
		UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, scale)
		draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}

	/// UIImage scaled to width with respect to aspect ratio.
	///
	/// - Parameters:
	///   - toWidth: new width.
	///   - opaque: flag indicating whether the bitmap is opaque.
	///   - orientation: optional UIImage orientation (default is nil).
	/// - Returns: optional scaled UIImage (if applicable).
	public func scaled(toWidth: CGFloat, opaque: Bool = false, with orientation: UIImage.Orientation? = nil) -> UIImage? {
		let scale = toWidth / size.width
		let newHeight = size.height * scale
		UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, scale)
		draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage
	}

	/// UIImage filled with color
	///
	/// - Parameter color: color to fill image with.
	/// - Returns: UIImage filled with given color.
	public func filled(withColor color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		color.setFill()
		guard let context = UIGraphicsGetCurrentContext() else { return self }

		context.translateBy(x: 0, y: size.height)
		context.scaleBy(x: 1.0, y: -1.0)
		context.setBlendMode(CGBlendMode.normal)

		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		guard let mask = self.cgImage else { return self }
		context.clip(to: rect, mask: mask)
		context.fill(rect)

		let newImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return newImage
	}

	/// UIImage tinted with color
	///
	/// - Parameters:
	///   - color: color to tint image with.
	///   - blendMode: how to blend the tint
	/// - Returns: UIImage tinted with given color.
	public func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
		let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		let context = UIGraphicsGetCurrentContext()
		context!.clip(to: drawRect, mask: cgImage!)
		color.setFill()
		UIRectFill(drawRect)
		draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
		let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return tintedImage!
	}

	/// UIImage with rounded corners
	///
	/// - Parameters:
	///   - radius: corner radius (optional), resulting image will be round if unspecified
	/// - Returns: UIImage with all corners rounded
	public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
		let maxRadius = min(size.width, size.height) / 2
		let cornerRadius: CGFloat
		if let radius = radius, radius > 0 && radius <= maxRadius {
			cornerRadius = radius
		} else {
			cornerRadius = maxRadius
		}

		UIGraphicsBeginImageContextWithOptions(size, false, scale)

		let rect = CGRect(origin: .zero, size: size)
		UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
		draw(in: rect)

		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}

}
