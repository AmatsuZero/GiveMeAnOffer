//
//  CIFilter+Extensions.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/8/12.
//

import Foundation

#if os(macOS)
import CoreImage
import Cocoa

public extension CIImage {
    
    typealias Filter = (CIImage) -> CIImage
    
    /// 高斯模糊滤镜
    ///
    /// - Parameter radius: 模糊半径
    /// - Returns: 模糊滤镜
    class func blur(radius: CGFloat) -> Filter {
        return { image in
            let parameters: [String: Any] = [
                kCIInputRadiusKey: radius,
                kCIInputImageKey: image
            ]
            guard let filter = CIFilter(name: "CIGaussianBlur",
                                        parameters: parameters) else { fatalError() }
            guard let outputImage = filter.outputImage else { fatalError() }
            return outputImage
        }
    }
    
    /// 生成固定颜色滤镜
    ///
    /// - Parameter color: 输入颜色
    /// - Returns: 固定颜色滤镜
    class func colorGenerator(color: NSColor) -> Filter {
        return { _ in
            guard let color = CIColor(color: color) else {
                fatalError()
            }
            let params: [String: Any] = [
                kCIInputColorKey: color
            ]
            guard let filter = CIFilter(name: "CIConstantColorGenerator",
                                        parameters: params) else { fatalError() }
            guard let outputImage = filter.outputImage else { fatalError() }
            return outputImage
        }
    }
    
    /// 合成滤镜
    ///
    /// - Parameter overlay: 叠加图像
    /// - Returns: 合成滤镜
    class func compositeSourceOver(overlay: CIImage) -> Filter {
        return { image in
            let params: [String: Any] = [
                kCIInputBackgroundImageKey: image,
                kCIInputImageKey: overlay
            ]
            guard let filter = CIFilter(name: "CISourceOverCompoting", parameters: params) else {
                fatalError()
            }
            guard let outputImg = filter.outputImage else {
                fatalError()
            }
            let cropRect = image.extent
            return outputImg.cropped(to: cropRect)
        }
    }
    
    
    /// 颜色叠加滤镜
    ///
    /// - Parameter color: 叠加颜色
    /// - Returns:
    class func colorOverlay(color: NSColor) -> Filter {
        return { image in
            let overlay = colorGenerator(color: color)(image)
            return compositeSourceOver(overlay: overlay)(image)
        }
    }
}

precedencegroup FilterGroup {
    associativity: left
    assignment: false
}

infix operator >>: FilterGroup
func >> (filter1: @escaping CIImage.Filter, filter2: @escaping CIImage.Filter) -> CIImage.Filter {
    return { image in filter2(filter1(image)) }
}

#endif
