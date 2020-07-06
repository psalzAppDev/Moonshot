//
//  AstronautView.swift
//  Moonshot
//
//  Created by Peter Salz on 06.07.20.
//  Copyright © 2020 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    @State var missionViewStyle: MissionViewStyle = .launchDates
    
    var body: some View {
        
        GeometryReader { geometry in            
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    VStack {
                        
                        Text("Missions")
                            .font(.headline)
                            .padding()
                        
                        ForEach(self.missions) { mission in
                            MissionCellView(mission: mission,
                                            viewStyle: self.$missionViewStyle)
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, allMissions: [Mission]) {
        
        self.astronaut = astronaut
        
        self.missions = allMissions.filter { mission in
            
            mission.crew.first(where: {
                $0.name == astronaut.id
            }) != nil
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0],
                      allMissions: missions)
    }
}
