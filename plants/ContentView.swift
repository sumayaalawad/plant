//
//  ContentView.swift
//  plants
//
//  Created by sumaya alawad on 07/05/1447 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var plants: [Plant] = []
    @State private var showingSetReminder = false
    @State private var navigateToToday = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("My plants🌱")
                    .font(.largeTitle)
                    .padding(.horizontal)
                    .bold()
                Divider()
                
               Spacer()
                VStack(spacing: 8) {
                Image("plant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 20)
                    Text("Start your plant journey!")
                        .font(.system(size: 25, weight: .semibold))

                    Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 40)
                }
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
                Spacer()
                VStack {
                    
                    Button {
                        showingSetReminder = true
                    } label: {
                        Text("Set Plant Reminder")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(25)
                            .font(.headline)
                    }
                    .padding(.horizontal)
                    
                    .navigationDestination(isPresented: $navigateToToday) {
                        TodayReminder(plants: $plants)
                    }
                }
                .sheet(isPresented: $showingSetReminder) {
                    SetReminderView(
                        plants: $plants,
                        onSave: {
                            showingSetReminder = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                navigateToToday = true
                            }
                        },
                        onCancel: {
                            showingSetReminder = false
                        }
                    )
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
