//
//  UIImage+CropCenterSquare.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import Foundation
import UIKit

extension UIImage {
    func cropCenterSquare(to size: CGFloat) -> UIImage? {
        let originalSize = min(self.size.width, self.size.height)
        let x = (self.size.width - originalSize) / 2.0
        let y = (self.size.height - originalSize) / 2.0
        let squareRect = CGRect(x: x, y: y, width: originalSize, height: originalSize)

        guard let cgImage = self.cgImage?.cropping(to: squareRect) else { return nil }

        let croppedImage = UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
        return UIGraphicsImageRenderer(size: CGSize(width: size, height: size)).image { _ in
            croppedImage.draw(in: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        }
    }
}
