//
//  ImageView.swift
//  myBowfolio
//
//  Created by weirong he on 8/28/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        
        TabView {
            Image("projects-page")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
