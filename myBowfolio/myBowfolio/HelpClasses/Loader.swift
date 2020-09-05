//
//  Loader.swift
//  myBowfolio
//
//  Created by weirong he on 9/4/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct Loader: UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
    }
}
