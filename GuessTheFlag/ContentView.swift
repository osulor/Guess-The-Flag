//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Consultant on 6/15/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia","Russia","Nigeria","Spain","US","UK","Poland","Italy","Germany",
        "Ireland"].shuffled()
    
    @State private  var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMessage = ""
    @State private var degrees = 0.0


    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of ")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                     .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number: number)
                        withAnimation {
                            self.degrees += 360
                            
                        }
                        
                    }) {
                        Image(self.countries[number])
                            
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black,radius: 4)
                    }
                    
                }
                .rotation3DEffect(.degrees(self.degrees), axis: (x: 1, y: 1, z: 1))
                

                Text("Score: \(score)")
                .foregroundColor(.white)
                    .font(.title)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
        }
    }
    
    
    
    func flagTapped(number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct!"
            score += 1
            alertMessage = "Current Score: \(score)"
        } else {
            scoreTitle = "Wrong!"
            if score > 0 {
                score -= 1
                alertMessage = "That's the flag of \(countries[number])"
            } else {
                alertMessage = "Game Over"
            }
            
        }
        
        showingScore = true
    }
    
    
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
