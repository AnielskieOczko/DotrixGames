//
//  MultiLineTextField.swift
//  DotrixGames
//
//  Created by Rafal on 16/05/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import SwiftUI


struct MultiLineTFView: View {
    
    @State var returnTxt: String
    @State var txt: String
    
    var body: some View {
        VStack {
            MultiLineTF(txt: txt, editeEnabled: true, returnTxt: $returnTxt)
//                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 20, maxHeight: 200)
                .border(Color.black.opacity(0.5), width: 1)
                .padding()
        }


    }
}


struct MultiLineTF: UIViewRepresentable {

    

    @State var txt: String
    @State var editeEnabled: Bool
    @Binding var returnTxt: String
    
    func makeCoordinator() -> Coordinator {
        
        return MultiLineTF.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MultiLineTF>) -> MultiLineTF.UIViewType {
        
        let tView = UITextView()
        tView.isEditable = editeEnabled
        tView.isUserInteractionEnabled = true
        tView.isScrollEnabled = true
        tView.text = txt
        tView.textColor = . gray
        tView.font = .systemFont(ofSize: 15)
        tView.delegate = context.coordinator
        return tView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTF>) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiLineTF
        
        init(parent1: MultiLineTF) {
            parent = parent1
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
            self.parent.returnTxt = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
}

struct MultiLineTextField_Previews: PreviewProvider {
    static var previews: some View {
        //@State var txt: String = "ss"
        MultiLineTFView(returnTxt: "", txt: "sdfgsg")
        
    }
}
