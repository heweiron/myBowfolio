//
//  ProfilesView.swift
//  myBowfolio
//
//  Created by weirong he on 8/30/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct ProfilesView: View {
    
    @ObservedObject private var viewModel = ProfilesViewModel()
    var body: some View {
        ScrollView {
            VStack {
                
                ForEach(viewModel.profiles, id: \.self) { profile in
                    ProfileCard(profile: profile)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                
        }.onAppear() {
            self.viewModel.fetchData()
        }
    }
}

struct ProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesView()
    }
}
