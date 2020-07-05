//
//  ContentView.swift
//  Moonshot
//
//  Created by Peter Salz on 05.07.20.
//  Copyright © 2020 Peter Salz App Development. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        
        Text("\(astronauts.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
