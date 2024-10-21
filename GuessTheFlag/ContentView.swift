//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Armando Francisco on 10/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)

    @State private var showScore = false
    @State private var scoreTitle = ""
    
    func flagTapped(_ number:Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                    }
                    
                }
            }
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue",action: askQuestion)
        } message: {
            Text("Your score is ???")
        }
    }
}

#Preview {
    ContentView()
}
