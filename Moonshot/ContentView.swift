//
//  ContentView.swift
//  Moonshot
//
//  Created by Peter Salz on 05.07.20.
//  Copyright © 2020 Peter Salz App Development. All rights reserved.
//

import SwiftUI

enum MissionViewStyle {
    
    case launchDates
    case crewNames
    
    mutating func toggle() {
        
        switch self {
        case .crewNames:
            self = .launchDates
        case .launchDates:
            self = .crewNames
        }
    }
}

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var missionViewStyle: MissionViewStyle = .launchDates
    
    var body: some View {
        
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, allMissions: self.missions)) {
                    
                    MissionCellView(mission: mission,
                                    viewStyle: self.$missionViewStyle)
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Toggle Subtitle") {
                self.missionViewStyle.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MissionCellView: View {
    
    let mission: Mission
    @Binding var viewStyle: MissionViewStyle
    
    var subtitle: String {
        switch self.viewStyle {
        case .launchDates:
            return mission.formattedLaunchDate
        case .crewNames:
            let subtitleString = mission.crew.reduce("", { $0 + "\($1.name), "})
            return String(subtitleString.dropLast(2))
        }
    }
    
    var body: some View {
        
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                
                Text(self.subtitle)
                
            }
            
            Spacer()
        }
    }
}
