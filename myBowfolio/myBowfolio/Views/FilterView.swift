//
//  FilterView.swift
//  myBowfolio
//
//  Created by weirong he on 8/31/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @State var showSelections: Bool = false
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
        

        
        GeometryReader { geometry in
            
            
            ZStack {
                
                ScrollView {
                    VStack {
                        
                        HStack {
                            Text("Interests:").fontWeight(.semibold)
                            Spacer()
                            Button(action: {
                                self.showSelections = true
                                self.interestsArray = self.getInterests()
                            }) {
                                Image(systemName: "plus")
                            }
                            
                        }.padding()
                        
                        
                        HStack {

                            generateContent(in: geometry, selectedArray: self.selectedArray)

                        }.padding(.bottom, 30)
                        Spacer()
                    }
                    
                    

                    // showing result section: profileCards
                    ForEach(self.getProfiles(interests: self.selectedArray), id:
                    \.self) { profile in
                        ProfileCard(profile: profile)
                    }
                    
                    
                }
                .onAppear() {

                    self.profilesViewModel.fetchData()
                    self.projectsViewModel.fetchData()
                }
                
                .background(Color.white)
                
                

                    Selections(showSelections: self.$showSelections, selectedArray: self.$selectedArray, itemsArray: self.$interestsArray).zIndex(self.showSelections ? 1 : -1)

                
            }.edgesIgnoringSafeArea(.bottom)

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
    
    @Binding var showSelections: Bool
    @Binding var selectedArray: [String]
    @Binding var itemsArray: [String]
    var body: some View {
        
        VStack {
            Spacer()
            VStack(spacing: 20) {
                
                VStack{
                    HStack{
                        Spacer()
                        Button(action: {
                            self.showSelections = false

                        }) {
                            Text("Done").font(.system(size: 22)).fontWeight(.semibold)
                        }
                    }.padding()
                    
                    ScrollView {
                        Divider()
                        ForEach(itemsArray, id: \.self) { item in
                            SelectionRow(selectedArray: self.$selectedArray, content: item)
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height*3/5)
            .background(Color(#colorLiteral(red: 0.8782730699, green: 0.878420651, blue: 0.8782535791, alpha: 1)))
                .cornerRadius(30)
        }.edgesIgnoringSafeArea(.bottom)

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
                self.selectedArray.remove(at: self.selectedArray.firstIndex(of: self.content)!)
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
        }.onAppear {
            if self.selectedArray.contains(self.content) {
                self.isSelected = true
            }
        }
    }

}



struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}




// make item in HStack can wrap if this line is full
func generateContent(in g: GeometryProxy, selectedArray: [String]) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    return ZStack(alignment: .topLeading) {
        ForEach(selectedArray, id: \.self) { selectedItem in
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
                    if selectedItem == selectedArray.last! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if selectedItem == selectedArray.last! {
                        height = 0 // last item
                    }
                    return result
                })
        }
    }
}
