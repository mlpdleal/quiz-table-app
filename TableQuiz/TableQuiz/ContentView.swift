//
//  ContentView.swift
//  TableQuiz
//
//  Created by Manoel Leal on 30/05/22.
//

import SwiftUI

struct Question {
    
    var questionText: String
    var correctQuestion: Int
    
}

struct ContentView: View {
    
    
    @State private var numberOfTable = 2
    @State private var quantity = 5
    @State private var numberOfQuestion = 0
    @State var yourAnswer = 0
    @State private var isFinish = false
    @FocusState private var valueIsFocused: Bool
    @State private var yourCorrectQuestionsCount = 0
    @State private var scoreTitle = ""
    @State private var showingMessageMatch = false
        
    var questions: Array<Question> {
        
        var arrayOfQuesion: Array<Question> = []
        
        for i in 0..<quantity {
            
            let question = Question(questionText: "What is the result of \(numberOfTable) x \(i)?" , correctQuestion: (numberOfTable * i))
            
            arrayOfQuesion.append(question)
          
        }
        
        return arrayOfQuesion
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Stepper("\(numberOfTable)", value: $numberOfTable, in: 2...12)
                } header: {
                    Text("Choose the number: ")
                }
                
                Section{
                    Picker("Quantity", selection: $quantity){
                        ForEach(0..<21){
                            if $0 % 5 == 0 && $0 != 15 && $0 != 0{
                                Text("\($0)")
                            }
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Choose the question quantity: ")
                }
                
                
                Section{
                   Text("\(questions[numberOfQuestion].questionText)")
                   TextField("Your answer",value: $yourAnswer, format: .number)
                        .keyboardType(.numberPad)
                        .focused($valueIsFocused)

                } header: {
                    Text("Question")
                }
                
           
                
            }.navigationTitle("Table Quiz ✖️")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            goToNextQuestion()
                        }
                        
                    }
                }
                
        }.alert(scoreTitle, isPresented: $showingMessageMatch){
            Button("OK") { }
        } message: {
            Text(scoreTitle == "Wrong value!" ? "The correct answer is \(questions[numberOfQuestion - 1].correctQuestion)" : "You got the question right!")
        }
        
        .alert("Finish", isPresented: $isFinish){
            Button("Restart") { }
        } message: {
            Text("Finish game! Your score is \(yourCorrectQuestionsCount)")
        }
        
        
    }
    
    func goToNextQuestion(){
        if yourAnswer == questions[numberOfQuestion].correctQuestion{
            yourCorrectQuestionsCount += 1
            scoreTitle = "Congratulations!"
        } else {
            scoreTitle = "Wrong value!"
        }
        
        numberOfQuestion += 1
        
        if numberOfQuestion == quantity{
            isFinish = true
            numberOfQuestion = 0
            yourAnswer = 0
        }
        
        if isFinish{
            showingMessageMatch = false
        } else {
            showingMessageMatch = true
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
