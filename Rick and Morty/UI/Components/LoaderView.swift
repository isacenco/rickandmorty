//
//  LoaderView.swift
//  Rick and Morty
//
//  Created by Ghenadie Isacenco on 4/7/23.
//

import SwiftUI

struct LoaderView: View {
    var tintColor: Color = .gray
    var scaleSize: CGFloat = 1.0

    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true:
            self.hidden()
        case false:
            self
        }
    }
}
