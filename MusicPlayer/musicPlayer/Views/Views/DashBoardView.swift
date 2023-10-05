//
//  ContentView.swift
//  musicPlayer
//
//  Created by Jaymeen Unadkat on 11/02/23.
//

import SwiftUI

struct DashBoardView: View {
    @EnvironmentObject var dashBoardVM: DashBoardViewModel
    @State var textFieldText: String = ""
    @State var selection: Int = 1
    @State var isShow: Bool = false
    @State var arrayData: [Artists] = [
        Artists(image: Constants.Image.kEdSheeran, name: "Ed Sheeran"),
        Artists(image: Constants.Image.kPanda, name: "Panda"),
        Artists(image: Constants.Image.kEdSheeran, name: "Ed Sheeran"),
        Artists(image: Constants.Image.kAliceChains, name: "AliceChains"),
        Artists(image: Constants.Image.kEdSheeran, name: "Ed Sheeran")
    ]
    
    @State var sheetIsPresented: Bool = false
    @State var songs: [Songs] = [
        Songs(image: Constants.Image.kBones, name: "Bones", artists: "Imagine Dragons",song: Constants.Audio.kBonesSong),
        Songs(image: Constants.Image.kPassenger, name: "Passenger", artists: "Michael David Rosenberg",song: Constants.Audio.kPassengerSong),
        Songs(image: Constants.Image.kShapeOfYou, name: "Shape of you", artists: "Ed Sheeran",song: Constants.Audio.kShapeOfYouSong),
        Songs(image: Constants.Image.kNights, name: "The Nights", artists: "Avicii",song: Constants.Audio.kNightsSong),
        
    ]
    init() {
        let appearance = UIToolbarAppearance()
        appearance.shadowColor = .clear
        UIToolbar.appearance().scrollEdgeAppearance = appearance
        UIToolbar.appearance().standardAppearance = appearance
    }
    var body: some View {
        
        NavigationView {
            
            VStack {
                ScrollView(showsIndicators: false) {
                    TextFieldView(textContent: $textFieldText)
                        .padding(.top, 30)
                    HStack {
                        Text(Constants.Descriptions.kArtistsOfWeek)
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .padding()
                            .padding(.leading, 20)
                        Spacer()
                    } // HStack
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                            withAnimation(Animation.easeIn(duration: 0.5)) {
                                self.isShow = true
                            }
                        })
                    }
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        LazyHStack(spacing: 40) {
                            ForEach(0 ..< arrayData.count, id: \.self) { i in
                                if isShow {
                                    GridCell(
                                        image: arrayData[i].image,
                                        name: arrayData[i].name,
                                        offset: 10,
                                        lineWidth: 7
                                    )
                                }
                            } // ForEach
                        } // LazyHStack
                        .padding([.horizontal,.bottom])
                    } // ScrollView
                    .frame(height: 250)
                    .padding([.horizontal,.bottom])
                    
                    HStack {
                        Text(Constants.Descriptions.kTopCharts)
                            .font(.system(size: 25, weight: .heavy, design: .rounded))
                            .padding()
                            .padding(.leading, 20)
                        Spacer()
                        Text(Constants.Descriptions.kSeeAll)
                            .font(.system(size: 15, weight: .heavy, design: .rounded))
                            .padding()
                    } // HStack
                    
                    Spacer()
                    
                    LazyVStack {
                        ForEach(0 ..< songs.count, id: \.self) { i in
                            if isShow {
                                HStack {
                                    CirclesView(
                                        fillColor: .gray,
                                        lineWidth: 10,
                                        offset: -10,
                                        ImageName: songs[i].image,
                                        type: 2,
                                        size: 80
                                    )
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .padding(.leading,20)
                                    .padding(.trailing,10)
                                    VStack (alignment: .leading){
                                        Text(songs[i].name)
                                            .font(.system(size: 25, weight: .bold, design: .rounded))
                                        Spacer()
                                        Text(songs[i].artists)
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                        Spacer()
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                .onTapGesture {
                                    withAnimation(Animation.spring()) {
                                        self.dashBoardVM.selectedData = songs[i]
                                        self.dashBoardVM.isSheetOpened = true
                                    }
                                    
                                }
                                .padding(.horizontal,20)
                                .padding(.vertical,10)
                            }
                        }
                    } // LazyVStack
                    
                } // ScrollView
                
                    if self.dashBoardVM.isPlaying == true {
                        HStack {
                            Image(systemName: "chevron.down")
                                .rotationEffect(Angle(degrees: 180))
                                .font(.system(size: 30, weight: .bold, design: .none))
                                .foregroundColor(.black)
                                .onTapGesture {
                                    withAnimation(Animation.spring()) {
//                                    self.dashBoardVM.selectedData = songs[i]
                                        self.dashBoardVM.isSheetOpened = true
                                    }
                                }
                                .padding(.horizontal,5)
                            
                            VStack(alignment: .leading) {
                                Text("\(self.dashBoardVM.selectedData.name)")
                                    .font(.system(size: 20, weight: .heavy, design: .rounded))
                                Text("\(self.dashBoardVM.selectedData.artists)")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                            } // VStack
                            .padding(.horizontal)
                            Spacer()
                            Button(action: {
                                if self.dashBoardVM.isPlaying {
                                    withAnimation {
                                        self.dashBoardVM.isPlaying = false
                                    }
                                    self.dashBoardVM.audioPlayer?.pause()
                                } else if !self.dashBoardVM.isPlaying {
                                    withAnimation {
                                        self.dashBoardVM.isPlaying = true
                                    }
                                    self.dashBoardVM.audioPlayer?.play()
                                }
                            }) {
                                
                                CirclesView(fillColor: .white, lineWidth: 4, offset: -5, ImageName: self.dashBoardVM.isPlaying ?
                                            "pause.fill" : "play.fill", type: 1, size: 50)
                                .frame(height: 45)
                            } // Button
                            
                        } //HStack
                        .padding()
                    }

                    
                BottomView(selection: self.$selection)

            } // VStack
            .background(Color.CustomBackgroundColor)

            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(Constants.Descriptions.kNavigationBarText)
                        .font(.system(size: 30, weight: .heavy, design: .none))
                        .padding()
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.dashBoardVM.isPlaying = false
                        } label: {
                            Image(systemName: Constants.Image.kRefresh)
                                .font(.system(size: 25, weight: .heavy, design: .none))
                                .tint(.black)
                        }
                        .fullScreenCover(isPresented: self.$dashBoardVM.isSheetOpened, onDismiss: {
                            
                        }, content: {                                                        
                            AudioPlayerView()
                        })
                }// ToolBar Items
            })
            .toolbarBackground(Color.CustomBackgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
        } // NavigationView
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}


