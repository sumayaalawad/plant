//
//  AllReminderCompleted.swift
//  plants
//
//  Created by sumaya alawad on 07/05/1447 AH.
//

import SwiftUI

struct AllReminderCompleted: View {
    @Binding var plants: [Plant]
    @State private var showingDeleteEdit = false

    var body: some View {
        NavigationView{
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading, spacing: 20) {
                    
                    HStack {
                        Text("My plants🌱")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.horizontal)

                    Divider()
                    
                    VStack {
                        Spacer()
                        
                        Image("plants")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.bottom, 20)
                        
                        Text("All Done!")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Text("All Reminders Completed")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Spacer()
                        
                        // زر تحت يمين
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
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingDeleteEdit) {
            DeleteEdit(plants: $plants, onSave: {
                showingDeleteEdit = false
            }, onCancel: {
                showingDeleteEdit = false
            })
        }
    }
}

#Preview {
    AllReminderCompleted(plants: .constant([]))
}
