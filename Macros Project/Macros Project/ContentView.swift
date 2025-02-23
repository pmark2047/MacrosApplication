//
//  ContentView.swift
//  Macros Project
//
//  Created by Peyton Markus on 2/18/25.
//

import SwiftUI

struct ContentView: View {
   @State private var selectedGender = 0
   @State private var weight : String = ""
   @State private var height : String = ""
   @State private var age : String = ""
   @State private var selectedActivityLvl = 0
   @State private var selectedGoal = 0
   
   private let genders = ["Male", "Female"]
   
   private let activityLevels =
   ["Sedentary (little or no exercise",
    "Lightly active (light exercise 1 to 3 days/week",
    "Moderately active (exercise 4 to 5 days/week",
    "Active (exercise 6 to 7 days/week",
    "Very active (exercise 6 to 7 times/week"]
   
   private let goals = ["Lose Weight", "Maintain Weight", "Gain Weight"]
   
   func CalculateCalories(_ selectedGender: Int, _ weight : String, _ height : String, _ age : String, _ selectedActivityLvl: Int, _ selectedGoal: Int) -> Double {
      var calories: Double = 0.0
      let gender = genders[selectedGender]
      let kgs = 0.453592 * (Double(weight) ?? 0.0)
      let cm = 2.54 * (Double(height) ?? 0.0)
      let years = Double(age) ?? 0.0
      let multipliers = [1.2, 1.375, 1.55, 1.725, 1.9]
      let activityMultiplier = multipliers[selectedActivityLvl]
      let goalPercentages = [0.90, 1, 1.10]
      let goalAdjustments = goalPercentages[selectedGoal]
      
      if kgs == 0 || cm == 0
      {
         return 0
      }
      if gender == "Male"
      {
         calories = ((10 * kgs) + (6.25 * cm) - (5 * years) - 161) * activityMultiplier * goalAdjustments
         return round(calories * 100) / 100
      }
      else
      {
         calories = ((10 * kgs) + (6.25 * cm) - (5 * years) + 5) * activityMultiplier * goalAdjustments
         return round(calories * 100) / 100
      }
   }
   
    var body: some View {
       NavigationView {
          Form {
             Section(header: Text("Convert a Currency")) {
                
                // Sex selector
                Picker(selection: $selectedGender, label: Text("Sex")) {
                   ForEach(0..<2) { index in
                      Text(self.genders[index]).tag(index)
                   }
                }
                
                // Input weight
                TextField("Weight (lbs)", text: $weight).keyboardType(.decimalPad)
                
                // Input height
                TextField("Height (in)", text: $height).keyboardType(.decimalPad)
                
                // Input height
                TextField("Age", text: $age).keyboardType(.decimalPad)
                
                Picker(selection: $selectedActivityLvl, label: Text("Activity Level")) {
                   ForEach(0..<5) { index in
                      Text(self.activityLevels[index]).tag(index)
                   }
                }
                
                Picker(selection: $selectedGoal, label: Text("Goal")) {
                   ForEach(0..<3) { index in
                      Text(self.goals[index]).tag(index)
                   }
                }
             }
             
             Section(header: Text("Daily Calorie Goal")) {
                Text("\(String(format: "%.2f", CalculateCalories(selectedGender, weight, height, age, selectedActivityLvl, selectedGoal))) Total Calories")
                Text("\(String(format: "%.2f", CalculateCalories(selectedGender, weight, height, age, selectedActivityLvl, selectedGoal) * 0.5 / 4)) Carbs")
                Text("\(String(format: "%.2f", CalculateCalories(selectedGender, weight, height, age, selectedActivityLvl, selectedGoal) * 0.2 / 4)) Proteins")
                Text("\(String(format: "%.2f", CalculateCalories(selectedGender, weight, height, age, selectedActivityLvl, selectedGoal) * 0.3 / 9)) Fats")
             }
          }
       }
        VStack {
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
