//
//  ProjectsView.swift
//  myBowfolio
//
//  Created by weirong he on 8/29/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct ProjectsView: View {
    
    @ObservedObject private var viewModel = ProjectsViewModel()
    var body: some View {
        ScrollView {
        VStack {
            
            ForEach(viewModel.projects, id: \.self) { project in
                ProjectCard(project: project)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }.onAppear() {
        self.viewModel.fetchData()
    }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
