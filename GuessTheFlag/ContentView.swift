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
    @State private var endScore = 0
    @State private var score = 0 {
        didSet {
            endScore = oldValue
        }
    }
    @State private var questionsCount = 0
    @State private var showReset = false
    
    func flagTapped(_ number:Int) {
        if questionsCount == 7 {
            scoreTitle = "End of Game"
            reset()
            askQuestion()
            return
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        
        
        showScore = true
        questionsCount += 1
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        showReset = true
        score = 0
        questionsCount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }

    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: .red, location: 0.3),
                .init(color: Color(red: 0.48, green: 0.83, blue: 0.2), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
//            LinearGradient(colors: [.red, .yellow], startPoint:   .top, endPoint: .bottom)
//                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            //.foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            //.foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 15)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding(30)
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue",action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(scoreTitle, isPresented: $showReset) {
            Button("Continue",action: reset)
        } message: {
            Text("Your was \(endScore)")
        }
    }
}

#Preview {
    ContentView()
}
