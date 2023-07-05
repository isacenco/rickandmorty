//
//  KFImageView.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 1/7/23.
//

import SwiftUI
import struct Kingfisher.KFImage

@ViewBuilder
func KFImageView(url: String) -> KFImage {
    KFImage(
        URL(string: url),
        options: [
            .transition(.fade(10.0))
        ]
    ).resizable()
}
