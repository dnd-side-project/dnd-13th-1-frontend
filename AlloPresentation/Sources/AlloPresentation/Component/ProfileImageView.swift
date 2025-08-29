//
//  ProfileImageView.swift
//  AlloPresentation
//
//  Created by 황채웅 on 8/29/25.
//

import SwiftUI
import Kingfisher
import UIKit

struct ProfileImageView: View {
    let url: URL?
    let uiImage: UIImage?
    let size: CGFloat
    let cornerRadius: CGFloat
    
    init(url: URL?, uiImage: UIImage? = nil, size: CGFloat, cornerRadius: CGFloat) {
        self.url = url
        self.uiImage = uiImage
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
            } else if let url = url {
                KFImage(url)
                    .resizable()
            } else {
                Image(.illustrationDefaultProfile)
                    .resizable()
            }
        }
        .scaledToFill()
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .inset(by: 1)
                .stroke(.gray200, lineWidth: 1)
        )
    }
}
