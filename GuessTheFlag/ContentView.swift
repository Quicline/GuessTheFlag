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
            LinearGradient(colors: [.black.opacity(01), .yellow], startPoint: .top, endPoint: .bottom)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 10)
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
