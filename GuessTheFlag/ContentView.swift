//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Armando Francisco on 10/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAlert = false
    
    var body: some View {
        
        Button("Show alert", role: .destructive) {
            showAlert = true
        }
        .buttonStyle(.borderedProminent)
        .alert("DANGER", isPresented: $showAlert) {
            //Button("Cancel") { }
            Button("Delete", role: .destructive) { }
        } message: {
            Text("gol")
        }
        
        
    }
}

#Preview {
    ContentView()
}
