//
//  TextFieldView.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 11/02/23.
//

import SwiftUI

struct TextFieldView: View {
    @State var placeHolder = "Search"
    @Binding var textContent: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(height: 50)
                .offset(x: 7, y: 7)
                .padding()
            ZStack {
                HStack {
                    TextField(self.placeHolder, text: $textContent)
                        .padding()
                        .padding(.leading,10)
                        .frame(height: 50)
                    Button {
                    } label: {
                        Image(systemName:"magnifyingglass")
                            .font(.system(size: 25, weight: .heavy, design: .none))
                            .tint(.black)
                            .offset(x:-15)
                    }
                }
                
            } // ZStack
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(.black,lineWidth:10)
            )
            .background(.white)
            .cornerRadius(50)
            .padding()
            
        } // ZStack
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(textContent: .constant(""))
    }
}


