//
//  FilterView.swift
//  QuickSkill
//
//  Created by Евгений Бухарев on 26.03.2024.
//

import SwiftUI

struct FilterView: View {
    @Binding var selectedSkillLevel: SkillLevel?
    @Binding var selectedTimeFrame: TimeFrame?
    @Binding var selectedCost: CostOption?
    
    var body: some View {
        VStack(spacing: 15) {
            // Clear Filter Button
            Button("Clear Filter") {
                selectedSkillLevel = nil
                selectedTimeFrame = nil
                selectedCost = nil
                
            }
            .foregroundStyle(Color("InputFieldsStroke"))
            .padding()
            
            VStack(spacing: 0) {
                Image(systemName: "chart.bar")
                    .resizable()
                    .frame(width: 25, height: 25)
                
                // Skill Level Picker
                Picker("Skill Level", selection: $selectedSkillLevel) {
                    ForEach(SkillLevel.allCases) { level in
                        Text(level.rawValue).tag(level as SkillLevel?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            VStack(spacing: 0) {
                Image(systemName: "clock")
                    .resizable()
                    .frame(width: 25, height: 25)
                
                // Time Frame Picker
                Picker("Time Frame", selection: $selectedTimeFrame) {
                    ForEach(TimeFrame.allCases) { frame in
                        Text(frame.rawValue).tag(frame as TimeFrame?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            VStack(spacing: 0) {
                Image(systemName: "tag")
                    .resizable()
                    .frame(width: 25, height: 25)
                
                // Cost Picker
                Picker("Cost", selection: $selectedCost) {
                    ForEach(CostOption.allCases) { option in
                        Text(option.rawValue).tag(option as CostOption?)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
        }
    }
}
