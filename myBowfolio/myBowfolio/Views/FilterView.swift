//
//  FilterView.swift
//  myBowfolio
//
//  Created by weirong he on 8/31/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @State var offsetValue: Int = 10
    @State var selectedArray: [String] = []
    @State var interestsArray: [String] = []
    @ObservedObject private var profilesViewModel = ProfilesViewModel()
    @ObservedObject private var projectsViewModel = ProjectsViewModel()
    
    func getInterests() -> [String] {
        var interestsArray: [String] = []
        
        //for profile in profilesViewModel.profiles {
        for profile in profilesViewModel.profiles {
            for interest in profile.interests {
                if interestsArray.contains(interest) == false {
                    interestsArray.append(interest)
                }
            }
        }

        //for project in projectsViewModel.projects {
        for project in projectsViewModel.projects {
            for interest in project.interests {
                if interestsArray.contains(interest) == false {
                    interestsArray.append(interest)
                }
            }
        }

        return interestsArray

    }
    

    var body: some View {
        

        
        GeometryReader {geometry in
            
            
            ZStack {
                
                ScrollView {
                    VStack {
                        
                        HStack {
                            Text("Interests:").fontWeight(.semibold)
                            Spacer()
                            Button(action: {
                                self.offsetValue = 1
                                self.interestsArray = self.getInterests()
                            }) {
                                Image(systemName: "plus")
                            }
                            
                        }.padding()
                        
                        
                        HStack {

                            self.generateContent(in: geometry)

                        }.padding(.bottom, 30)
                        Spacer()
                    }
                    
                    

                    // showing result section: profileCards
                    ForEach(self.getProfiles(interests: self.selectedArray), id:
                    \.self) { profile in
                        ProfileCard(profile: profile)
                    }
                    
                    
                }.onAppear() {
                    self.profilesViewModel.fetchData()
                    self.projectsViewModel.fetchData()
                }
                
                
                
                Selections(offsetValue: self.$offsetValue, selectedArray: self.$selectedArray, interestsArray: self.$interestsArray)
                    .animation(.default)
            }
            
        }
    }
    
    // make item in HStack can wrap if this line is full
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(self.selectedArray, id: \.self) { selectedItem in
                Text("  \(selectedItem)  ")
                .fontWeight(.semibold)
                .background(Color(#colorLiteral(red: 0.4322651923, green: 0.5675497651, blue: 0.8860189915, alpha: 1)))
                .foregroundColor(Color.white)
                .cornerRadius(20)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if selectedItem == self.selectedArray.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if selectedItem == self.selectedArray.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
    
    // Get profiles by given interests

    func getProfiles(interests: [String]) -> [Profile]{
        var profiles: [Profile] = []
        for profile in profilesViewModel.profiles {
            var isContains = false
            for interest in interests {
                if profile.interests.contains(interest) {
                    isContains = true
                }
            }
            if isContains {
                profiles.append(profile)
            }
        }
        
        return profiles
    }
    
}

struct Selections: View {
    @ObservedObject private var profilesViewModel = ProfilesViewModel()
    @ObservedObject private var projectsViewModel = ProjectsViewModel()

    @Binding var offsetValue: Int
    @Binding var selectedArray: [String]
    @Binding var interestsArray: [String]
    var body: some View {
        VStack(spacing: 20) {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        self.offsetValue = 10
                    }) {
                        Text("Done").font(.system(size: 22)).fontWeight(.semibold)
                    }
                }.padding()
                
                ScrollView {
                    Divider()
                    ForEach(interestsArray, id: \.self) { interest in
                        SelectionRow(selectedArray: self.$selectedArray, content: interest)
                    }
                }
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height*3/5)
            .background(Color(#colorLiteral(red: 1, green: 0.956505239, blue: 0.9437020421, alpha: 1)))
        .cornerRadius(30)
            .offset(y: CGFloat(self.offsetValue) * UIScreen.main.bounds.height*1/8)
        .onAppear() {
            self.profilesViewModel.fetchData()
        }
        

    }
    
    func getInterests() -> [String] {
        var interestsArray: [String] = []

        //for profile in profilesViewModel.profiles {
        for profile in profilesViewModel.profiles {
            for interest in profile.interests {
                if interestsArray.contains(interest) == false {
                    interestsArray.append(interest)
                }
            }
        }

        //for project in projectsViewModel.projects {
        for project in projectsViewModel.projects {
            for interest in project.interests {
                if interestsArray.contains(interest) == false {
                    interestsArray.append(interest)
                }
            }
        }

        return interestsArray

    }
}

struct SelectionRow: View {
    @State var isSelected = false
    @Binding var selectedArray: [String]
    
    var content: String
    var body: some View {
        VStack {
        Button(action: {
            
            self.isSelected.toggle()
            
            if self.isSelected {
                self.selectedArray.append(self.content)
               print(self.selectedArray)
                
            } else {
                self.selectedArray.removeLast()
                print(self.selectedArray)
            }
        }) {
            HStack{
                Text(content)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark").foregroundColor(Color.blue)
                }
                
                
            }.font(.system(size: 25)).padding()
        }.foregroundColor(Color.black)
        Divider()
        }
    }

}



struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}



