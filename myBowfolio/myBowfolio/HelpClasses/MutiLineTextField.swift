//
//  MutiLineTextField.swift
//  myBowfolio
//
//  Created by weirong he on 9/5/20.
//  Copyright © 2020 weirong he. All rights reserved.
//

import SwiftUI


struct MutiLineTextField: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeCoordinator() -> MutiLineTextField.Coordinator {
        
        return MutiLineTextField.Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: UIViewRepresentableContext<MutiLineTextField>) -> UITextView {
        
        let tview = UITextView()
        tview.isEditable = true
        tview.isUserInteractionEnabled = true
        tview.isScrollEnabled = true
        tview.text = self.text
        tview.textColor = .gray
        tview.font = .systemFont(ofSize: 16)
        tview.delegate = context.coordinator
        return tview
    }
    
    func updateUIView(_ uiView: UITextView , context: UIViewRepresentableContext<MutiLineTextField>) {
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MutiLineTextField
        
        init(parent1: MutiLineTextField) {
            parent = parent1
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = parent.text
            
            // to fit dark mode
            textView.textColor = .label
        }
    }
}






struct MutiLineTextFieldView: View {
    
    @State var text = "ABc"
    var body: some View {
        VStack {
            MutiLineTextField(text: $text)
            Button(action: {
            }) {
                Text("Print")
            }
        }
    }
}

struct MutiLineTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        MutiLineTextFieldView()
    }
}
