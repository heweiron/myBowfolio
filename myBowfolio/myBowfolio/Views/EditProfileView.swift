//
//  EditProfileView.swift
//  myBowfolio
//
//  Created by weirong he on 9/2/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
        @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
        @State private var name = Array<String>.init(repeating: "", count: 3)

        var body: some View {

            VStack {
                Group {
                    Text("Some filler text").font(.largeTitle)
                    Text("Some filler text").font(.largeTitle)
                }

                TextField("text #1", text: $name[0], onEditingChanged: { if $0 { self.kGuardian.showField = 0 } })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(GeometryGetter(rect: $kGuardian.rects[0]))

                TextField("text #2", text: $name[1], onEditingChanged: { if $0 { self.kGuardian.showField = 1 } })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(GeometryGetter(rect: $kGuardian.rects[1]))

                TextField("text #3", text: $name[2], onEditingChanged: { if $0 { self.kGuardian.showField = 2 } })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(GeometryGetter(rect: $kGuardian.rects[2]))

                }.offset(y: kGuardian.slide).animation(.easeInOut(duration: 1.0)).onAppear { self.kGuardian.addObserver() }
                .onDisappear { self.kGuardian.removeObserver() }
        }

    }

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
