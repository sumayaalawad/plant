//
//  Untitled 2.swift
//  plants
//
//  Created by sumaya alawad on 07/05/1447 AH.
//

import SwiftUI

struct TodayReminder: View {
    @Binding var plants: [Plant]
    @State private var showAllReminderCompleted = false
    @State private var showingDeleteEdit = false
    
    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }
    
    var allWatered: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("My plants🌱")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    if !plants.isEmpty {
                        EditButton()
                            .foregroundColor(.green)
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                if plants.isEmpty {
                    Spacer()
                    Text("Your plants are waiting for a sip 💦")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.horizontal)
                    Spacer()
                } else {
                    VStack(spacing: 10) {
                        if wateredCount == 0 {
                            Text("Your plants are waiting for a sip💦")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        } else if allWatered {
                            Text("\(wateredCount) of your plants feel loved today ✨")
                                .foregroundColor(.white)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                        
                        ProgressView(value: Double(wateredCount), total: Double(plants.count))
                            .tint(.green)
                            .padding(.vertical)
                    }
                    .frame(maxWidth: .infinity)
                    
                    List {
                        ForEach($plants) { $plant in
                            HStack {
                                Button {
                                    plant.isWatered.toggle()
                                    checkIfAllWatered()   
                                } label: {
                                    Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(plant.isWatered ? .green : .gray)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(plant.name)
                                        .foregroundColor(.white)
                                    Text("in \(plant.location)")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Label(plant.sun, systemImage: "sun.max")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                    Label(plant.water, systemImage: "drop")
                                        .foregroundColor(.blue)
                                        .font(.caption)
                                }
                            }
                            .listRowBackground(Color(.secondarySystemBackground).opacity(0.2))
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    if let idx = plants.firstIndex(where: { $0.id == plant.id }) {
                                        plants.remove(at: idx)
                                        checkIfAllWatered()
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .onMove { indices, newOffset in
                            plants.move(fromOffsets: indices, toOffset: newOffset)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    
                    HStack {
                        Spacer()
                        Button {
                            showingDeleteEdit = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                }
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showingDeleteEdit) {
                DeleteEdit(plants: $plants, onSave: {
                    showingDeleteEdit = false
                }, onCancel: {
                    showingDeleteEdit = false
                })
            }
            // ✅
            .sheet(isPresented: $showAllReminderCompleted) {
                AllReminderCompleted()
            }
        }
    }
    
    // ✅      وتفتح
    private func checkIfAllWatered() {
        if allWatered {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showAllReminderCompleted = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        TodayReminder(plants: .constant([
            Plant(name: "Monstera", location: "Living Room", sun: "Medium", water: "Every 3 days", isWatered: false),
            Plant(name: "Cactus", location: "Balcony", sun: "High", water: "Once a week", isWatered: false)
        ]))
    }
}
