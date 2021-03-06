//
//  MissionView.swift
//  Moonshot
//
//  Created by Peter Salz on 06.07.20.
//  Copyright © 2020 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    let allMissions: [Mission]
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.formattedLaunchDate)
                        .padding()
                        .font(.headline)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, allMissions: self.allMissions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(crewMember.role == "Commander"
                                        ? Capsule().stroke(Color.blue, lineWidth: 3)
                                        : Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName),
                            displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut], allMissions: [Mission]) {
        
        self.mission = mission
        self.allMissions = allMissions
        
        var matches = [CrewMember]()
        for member in mission.crew {
            guard let match = astronauts.first(where: {
                $0.id == member.name
            }) else {
                fatalError("Missing \(member)")
            }
            
            matches.append(CrewMember(
                role: member.role,
                astronaut: match
            ))
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        
        MissionView(mission: missions[0], astronauts: astronauts, allMissions: missions)
    }
}
