//
//  ContentView.swift
//  Moonshot
//
//  Created by Peter Salz on 05.07.20.
//  Copyright © 2020 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        
        Text("\(astronauts.count), \(missions.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
