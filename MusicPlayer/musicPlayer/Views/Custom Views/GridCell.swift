//
//  GridCell.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 11/02/23.
//

import SwiftUI

struct GridCell: View {
    var image: String = "EdSheeran"
    var name: String = "Ed Sheeran"
    var size: Double = 150
    var offset: Double = 15
    var cornerRadius: Double = 20
    var lineWidth: Double = 10
    var font: Double = 25
    var fontWeight: Font.Weight = .bold
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: size, height: size, alignment: .center)
                    .offset(x: offset, y: offset)
                
                Image(image)
                    .resizable(resizingMode: .stretch)
                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: lineWidth)
                    )
                    .frame(width: size, height: size, alignment: .center) // Image
                
            } // ZStack
            
            Text(name)
                .font(.system(size: font, weight: fontWeight, design: .rounded))
                .padding()
            
        } // VStack
    }
}

struct GridCell_Previews: PreviewProvider {
    static var previews: some View {
        GridCell()
    }
}
