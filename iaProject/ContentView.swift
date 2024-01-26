//
//  ContentView.swift
//  iaProject
//
//  Created by Lou RASSAT on 1/26/24.
//

import SwiftUI

enum Sentiment: String {
    case positive = "POSITIVE"
    case negative = "NEGATIVE"
    case mixed = "MIXED"
    case neutral = "NEUTRAL"
}

extension Sentiment {
    func getColor() -> Color {
        switch self{
        case .positive:
            return .green
        case .negative:
            return .red
        case .mixed:
            return .purple
        case .neutral:
            return .gray
        }
    }
 }

extension Sentiment {
    func getEmoji() -> String {
        switch self{
        case .positive:
            return "😃"
        case .negative:
            return "😔"
        case .mixed:
            return "😕"
        case .neutral:
            return "😐"
        }
    }
 }

struct ContentView: View {
    @State private var sentimentText: String = ""
    @State private var outputSentiment: Sentiment?
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack {
                    Text("Entrez une phrase, l'IA va deviner votre sentiment ")
                        .font(.system(size: 20))
                        .lineLimit(2)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    TextEditor(text: $sentimentText)
                        .frame(height: 100)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                        .cornerRadius(15)
                        .padding()
                        .onChange(of: sentimentText) { oldValue, newValue in
                            outputSentiment = nil
                        }
                        

                    Button(action: {
                        guessSentiment()
                    }) {
                        Text("Devinez le sentiment")
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(.purple)
                .cornerRadius(15)
                .foregroundStyle(.white)
            }
            .navigationTitle("🧠 IA du futur")
            .padding()
            VStack{
                Text(outputSentiment?.getEmoji() ?? "")
                    .font(.system(size: 40))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text(outputSentiment?.rawValue ?? "")
                    .font(.system(size: 40, weight: .bold))
                    .font(.title)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .background(outputSentiment?.getColor() ?? .white)
            .cornerRadius(15)
        }
    }

    
    func guessSentiment() {
        do {
            // MyModel est une classe générée automatiquement par Xcode
            let model = try Sentimentiutacy_1(configuration: .init())
            let prediction = try model.prediction(text: sentimentText)
            outputSentiment = Sentiment(rawValue: prediction.label.uppercased())
        } catch {
            print("Something went wrong")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
