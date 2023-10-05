//
//  AudioPlayerView.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 12/02/23.
//

import SwiftUI
import AVKit
 struct AudioPlayerView: View {
     @EnvironmentObject var dashBoardVM: DashBoardViewModel
     @State var changeProgress: Double = 0.0
     @State var isSelected: Bool = false
     
     var body: some View {
         VStack {
             HStack {
                 Spacer()
                 Button {
                     withAnimation(Animation.spring()) {
                         self.dashBoardVM.isSheetOpened = false
                     }
                     
                 } label: {
                     Image(systemName: "chevron.down")
                         .font(.system(size: 30, weight: .bold, design: .none))
                         .foregroundColor(.black)
                 }
                 Spacer()
                 Text("NOW PLAYING")
                     .font(.system(size: 30, weight: .heavy, design: .rounded))
                     .padding()
                 Spacer()
                 Button {
                     isSelected.toggle()
                 } label: {
                     Image(systemName: isSelected ? "heart.fill" : "heart")
                         .font(.system(size: 30, weight: .bold, design: .none))
                         .foregroundColor(.black)
                 }
                 Spacer()
             } // HStack
             .padding(.top , 30)
             VStack(spacing: 0) {
                 GridCell(image: self.dashBoardVM.selectedData.image, name: self.dashBoardVM.selectedData.name, size: 250, offset: 10, cornerRadius: 30, lineWidth: 5,font: 30,fontWeight: .heavy)
                 Text(self.dashBoardVM.selectedData.artists)
                     .font(.system(size: 25, weight: .heavy, design: .rounded))
             }
             .padding()
             .padding(.top, 30)
             Spacer()
             HStack {
                 GeometryReader { gr in
                     Capsule()
                         .strokeBorder(lineWidth: 3, antialiased: true)
                         .background(
                             Capsule()
                                 .foregroundColor(Color.black)
                                 .frame(width: gr.size.width * self.dashBoardVM.progress, height: 8), alignment: .leading)
                         .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ (value) in
                                    let translation = value.translation
                                    self.changeProgress = translation.width / gr.size.width
                                })
                                .onEnded({ (value) in
                                    self.dashBoardVM.updateTimer(value: self.changeProgress)
                                })
                            
                         )
                 }
                 .frame( height: 8)

             }
             .padding()
             .frame(height: 50, alignment: .center)
             .accessibilityElement(children: .ignore)
             .accessibility(identifier: "audio player")
             .accessibilityLabel(self.dashBoardVM.isPlaying ? Text("Playing at ") : Text("Duration"))
             .accessibilityValue(Text("\(self.dashBoardVM.formattedProgress)"))

             HStack {
                 Text(self.dashBoardVM.formattedProgress)
                     .font(.system(size: 20, weight: .bold, design: .rounded))
                 Spacer()
                 Text(self.dashBoardVM.formattedDuration)
                     .font(.system(size: 20, weight: .bold, design: .rounded))
             }
             .padding()
             
             //             the control buttons
             HStack(alignment: .center, spacing: Constants.SCREEN_WIDTH / 16) {
                 Button {
                     
                 } label: {
                     Image(systemName: "repeat")
                         .font(.system(size: 30, weight: .bold, design: .none))
                         .foregroundColor(.black)
                 }
                 Button {
                     let decrease = self.dashBoardVM.audioPlayer!.currentTime - 15
                     if decrease < 0.0 {
                         self.dashBoardVM.audioPlayer!.currentTime = 0.0
                     } else {
                         self.dashBoardVM.audioPlayer!.currentTime -= 15
                     }
                 } label: {
                     Image(systemName: "backward.fill")
                         .font(.system(size: 30, weight: .bold, design: .none))
                         .foregroundColor(.black)
                 }
                 

                 Button(action: {
                     if self.dashBoardVM.isPlaying == true {
                         if self.dashBoardVM.audioPlayer!.isPlaying {
                             withAnimation {
                                 self.dashBoardVM.isPlaying = false
                             }
                             self.dashBoardVM.audioPlayer!.pause()
                         }
                     }else if self.dashBoardVM.isPlaying == false {
                         if !self.dashBoardVM.audioPlayer!.isPlaying {
                             withAnimation {
                                 self.dashBoardVM.isPlaying = true
                             }
                             
                             self.dashBoardVM.audioPlayer!.play()
                         }
                     }
                 }) {
                     CirclesView(fillColor: .white, lineWidth: 5, offset: -10, ImageName: self.dashBoardVM.isPlaying ?
                                 "pause.fill" : "play.fill", type: 1)
                     .frame(height: 80)
                 }
                 Button {
                     let increase = self.dashBoardVM.audioPlayer!.currentTime + 15
                     if increase < self.dashBoardVM.audioPlayer!.duration {
                         self.dashBoardVM.audioPlayer!.currentTime = increase
                     } else {
                         // give the user the chance to hear the end if he wishes
                         self.dashBoardVM.audioPlayer!.currentTime = self.dashBoardVM.duration
                     }
                 } label: {
                     Image(systemName: "forward.fill")
                         .font(.system(size: 30, weight: .bold, design: .none))
                         .foregroundColor(.black)
                 }

                 Button {
                     let increase = self.dashBoardVM.audioPlayer!.currentTime + 15
                     if increase < self.dashBoardVM.audioPlayer!.duration {
                         self.dashBoardVM.audioPlayer!.currentTime = increase
                     } else {
                         // give the user the chance to hear the end if he wishes
                         self.dashBoardVM.audioPlayer!.currentTime = self.dashBoardVM.duration
                     }
                 } label: {
                     Image(systemName: "shuffle")
                         .font(.system(size: 30, weight: .bold, design: .none))
                         .foregroundColor(.black)
                 }
             } //HStack
             .frame(width: Constants.SCREEN_WIDTH)
             .padding(.horizontal, 20)
             .padding(.bottom , 60)
             
         } // VStack
         .frame(height: Constants.SCREEN_HEIGHT)
         .background(Color.CustomBackgroundColor)
         .onAppear {
             if self.dashBoardVM.isPlaying == false {
                 initialiseAudioPlayer()
             }
             
         }
     }
 }
