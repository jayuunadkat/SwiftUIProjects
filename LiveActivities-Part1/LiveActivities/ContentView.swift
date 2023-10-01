//
//  ContentView.swift
//  LiveActivities
//
//  Created by differenz239 on 25/09/23.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct ContentView: View {
    // MARK: - Updating Live Activities
    @State var currentID: String = ""
    @State var currentSelection: Status = .received
    var body: some View {
        NavigationStack{
            VStack{
                Picker(selection: $currentSelection) {
                    Text("Received")
                        .tag(Status.received)
                    Text("Progress")
                        .tag(Status.progress)
                    Text("Ready")
                        .tag(Status.ready)
                }label: {
                }
                .labelsHidden()
                .pickerStyle(.segmented)
                // MARK: - Initializing Activity
                Button("Start Activity"){
                    addLiveActivity()
                }
                .padding(.top)
                
                // MARK: - Removing Activity
                Button("Remove Activity"){
                    removeActivity()
                }
                .padding(.top)
            }
            .navigationTitle("Live Activities")
            .padding(15)
            .onChange(of: currentSelection) { newValue in
                // Retrieving current activity from the list of phone activities
                if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
                    activity.id == currentID
                }){
                    print("Activity Found")
                    // since i need to show the animation i am delaying action for 2s
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        var updatedState = activity.contentState
                        updatedState.status = currentSelection
                        Task{
                            await activity.update(using: updatedState)
                        }
                    }
                }
            }
        }
    }
    
    func removeActivity(){
        if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
            activity.id == currentID
        }){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                Task{
                    await activity.end(using: activity.contentState, dismissalPolicy: .immediate)
                }
            }
        }
    }
    
    // MARK: - we need to add a key in info.plist file
    func addLiveActivity(){
        let orderAttributes = OrderAttributes(orderNumber: 26383, orderItems: "Burger and Milk Shake")
        let initialContentState = OrderAttributes.ContentState()
        do{
            let activity = try Activity<OrderAttributes>.request(attributes: orderAttributes, contentState: initialContentState, pushType: nil)
            // MARK: - Storing CurrentID for Updating Activity
            currentID = activity.id
            print("Activity Added Successfully... id:\(activity.id)")
            
        }catch{
            print(error.localizedDescription)
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
