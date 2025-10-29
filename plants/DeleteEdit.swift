//
//  DeleteEdit.swift
//  plants
//
//  Created by sumaya alawad on 07/05/1447 AH.
//
// gg
import SwiftUI

struct DeleteEdit: View {
    @Binding var plants: [Plant]
    @State private var showDeleteEdit = false
    var onSave: () -> Void
    var onCancel: () -> Void
    
    @State private var plantName = ""
    @State private var selectedRoom = "Bedroom"
    @State private var selectedLight = "Full sun"
    @State private var wateringDays = "Every day"
    @State private var selectedWaterAmount = "25-50 ml"
    
    let rooms = ["Bedroom", "Living room", "Kitchen", "Balcony", "Bathroom"]
    let lightOptions = ["Full sun", "Partial sun", "Low light"]
    let wateringOptions = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["25-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing:45) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height:55)
                    .overlay(
                        HStack {
                            Text("Plant Name")
                                .foregroundColor(.white)
                            Spacer()
                            ZStack(alignment: .leading) {
                                if plantName.isEmpty {
                                    Text("Pothos")
                                        .foregroundColor(.white .opacity(0.5))
                                }
                                TextField("", text: $plantName)
                                    .foregroundColor(.white .opacity(0.9))
                            }
                            .padding(.horizontal, 20)
                        })
                    .padding(.horizontal)
                
                Form {
                    
                    Section {
                        Picker("Select Room", selection: $selectedRoom) {
                            ForEach(rooms, id: \.self) { Text($0) }
                        }
                        Picker("Select Light", selection: $selectedLight) {
                            ForEach(lightOptions, id: \.self) { Text($0) }
                        }
                    }
                    Section {
                        Picker("Watering Frequency", selection: $wateringDays) {
                            ForEach(wateringOptions, id: \.self) { Text($0) }
                        }
                        Picker("Water Amount", selection: $selectedWaterAmount) {
                            ForEach(waterAmounts, id: \.self) { Text($0) }
                        }
                    }
                    
                    Section {
                        Button(role: .destructive) {
                            if !plants.isEmpty {
                                plants.removeLast()
                            }
                            onCancel()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Delete Plant")
                                Spacer()
                            }
                        }
                    }
         
                    .listRowBackground(Color.gray.opacity(0.2))
                    .padding(.top, 8)
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            onCancel()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("Set Reminder")
                            .font(.headline)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            let newPlant = Plant(
                                name: plantName,
                                location: selectedRoom,
                                sun: selectedLight,
                                water: selectedWaterAmount,
                                isWatered: false
                            )
                            plants.append(newPlant)
                            onSave()
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    DeleteEdit(plants: .constant([]), onSave: {}, onCancel: {})
}
