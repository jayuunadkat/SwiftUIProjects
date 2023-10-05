//
//  CirclesView.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 11/02/23.
//

import SwiftUI

//MARK: - CUSTOM GRAY COLOR

struct CirclesView: View {
    
    var fillColor: Color
    var lineWidth: Double
    var offset: Double
    var ImageName: String
    var type: Int // 1 for System else Custom Image
    var size: Double = 50
    var body: some View {
        ZStack {
            Circle()
                .fill(.black)
            Circle()
                .foregroundColor(fillColor)
                .offset(x: offset, y: offset)
            Circle()
                .stroke(.black, lineWidth: lineWidth)
                .offset(x: offset, y: offset)
            if type == 1 {
                Image(systemName: ImageName)
                    .tint(.black)
                    .font(.system(size: size - 20).bold())
                    .offset(x: offset, y: offset)
            } else {
                Image(ImageName)
                    .resizable()
                    .cornerRadius(size)
                    .frame(width: size, height: size, alignment: .center)
                    .offset(x: offset, y: offset)
            }
        } //ZStack
        
    }
}

struct CirclesView_Previews: PreviewProvider {
    static var previews: some View {
        CirclesView(fillColor: Color.white,lineWidth: 5,offset: -10,ImageName: "EdSheeran",type: 2)
    }
}
