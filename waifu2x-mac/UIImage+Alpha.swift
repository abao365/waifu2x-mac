//
//  NSImage+Alpha.swift
//  waifu2x
//
//  Created by 谢宜 on 2017/12/29.
//  Copyright © 2017年 xieyi. All rights reserved.
//

import Foundation

extension NSImage {
    
    func alpha() -> [UInt8] {
        let width = Int(self.representations[0].pixelsWide)
        let height = Int(self.representations[0].pixelsHigh)
        var rect = NSRect.init(origin: .zero, size: CGSize(width: width, height: height))
        let cgimg = self.representations[0].cgImage(forProposedRect: &rect, context: nil, hints: nil)
        let data = UnsafeMutablePointer<UInt8>.allocate(capacity: width * height)
        let alphaOnly = CGContext(data: data, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width, space: CGColorSpace.init(name: CGColorSpace.linearGray)!, bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue)
        alphaOnly?.draw(cgImage(forProposedRect: &rect, context: nil, hints: nil)!, in: CGRect(x: 0, y: 0, width: width, height: height))
        var result: [UInt8] = []
        for i in 0 ..< width * height {
            result.append(data[i])
        }
        return result
    }
    
}
