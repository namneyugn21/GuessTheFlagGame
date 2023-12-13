//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nam Vu Hai Nguyen on 2023-12-13.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreTitle: String = ""
    @State private var tof: Bool = false
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "United Kingdom", "United States", "Ukraine"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var chosenAnswer: Int = 0
    @State private var currentScore: Int = 0
    @State private var showingScore: Bool = false
    @State private var rounds: Int = 8
    @State private var currentRound: Int = 1
    @State private var endGame: Bool = false
    
    var body: some View {
        ZStack {
            //LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.19, blue: 0.33), location: 0.3),
                .init(color: Color(red: 0.25, green: 0.47, blue: 0.75), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(Color(red: 0.84, green: 0.97, blue: 1.0))
                VStack(spacing: 20) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(Color(red: 0.84, green: 0.97, blue: 1.0))                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(chosen: number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 15))
                Spacer()
                Spacer()
                Text("Score: \(currentScore)")
                    .foregroundStyle(Color(red: 0.84, green: 0.97, blue: 1.0))
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: shuffleAgain)
        } message: {
            if (tof == true) {
                Text("Correct! It was \(countries[correctAnswer])")
            } else {
                Text("Incorrect! The chosen flag was \(countries[chosenAnswer])")
            }
        }
        .alert("Overview", isPresented: $endGame) {
            Button("Play Again!", action: restart)
        } message: {
            Text("""
            Correct: \(currentScore)
            Incorrect: \(rounds - currentScore)
            Great job!
            """)
        }
    }
    func flagTapped(chosen: Int) {
        if (currentRound == rounds) {
            endGame = true
        } else {
            if chosen == correctAnswer {
                scoreTitle = "Round \(currentRound) of \(rounds)"
                currentScore += 1
                currentRound += 1
                tof = true
            } else {
                scoreTitle = "Round \(currentRound) of \(rounds)"
                tof = false
                currentRound += 1
                chosenAnswer = chosen
            }
            showingScore = true
        }
    }
    func shuffleAgain() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func restart() {
        currentScore = 0
        currentRound = 1
        shuffleAgain()
    }
}

#Preview {
    ContentView()
}
