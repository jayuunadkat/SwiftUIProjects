//
//  BottomView.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 13/02/23.
//

import SwiftUI

struct BottomView: View {
    @Binding var selection: Int
    var body: some View {
        VStack (spacing: 0){
            
            Button {
                
            } label: {
                Text("")
            }
            .frame(width: Constants.SCREEN_WIDTH,height: 2)
            .background(.black)
            .offset(y: -5)
            HStack(spacing: Constants.SCREEN_WIDTH / 6) {
                
                Button {
                    self.selection = 1
                } label: {
                    VStack {
                        Image(systemName: "house.fill")
                            .tint(self.selection == 1 ? .black : .gray)
                            .font(.system(size: 20))
                            .padding(.top,5)
                        Text("Home")
                            .font(.system(size: 20, weight: .bold, design: .none))
                            .foregroundColor(self.selection == 1 ? .black : .gray)
                    }
                    .scaleEffect(self.selection == 1 ? 1.1 : 1)
                } // Button1
                Button {
                    self.selection = 2
                } label: {
                    VStack {
                        Image(systemName: "music.note.list")
                            .tint(self.selection == 2 ? .black : .gray)
                            .font(.system(size: 20))
                        
                        Text("Library")
                            .font(.system(size: 15, weight: .bold, design: .none))
                            .foregroundColor(self.selection == 2 ? .black : .gray)
                    }
                    .scaleEffect(self.selection == 2 ? 1.2 : 1)
                } // Button2
                
                Button {
                    self.selection = 3
                } label: {
                    VStack {
                        Image(systemName: "person.fill")
                            .tint(self.selection == 3 ? .black : .gray)
                            .font(.system(size: 25))
                        Text("Profile")
                            .font(.system(size: 15, weight: .bold, design: .none))
                            .foregroundColor(self.selection == 3 ? .black : .gray)
                    }
                    .scaleEffect(self.selection == 3 ? 1.2 : 1)
                } // Button3
            

            } // HStack
            .frame(width: Constants.SCREEN_WIDTH,height: 40)
        }
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView(selection: .constant(0))
    }
}
