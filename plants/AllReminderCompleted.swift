//
//  AllReminderCompleted.swift
//  plants
//
//  Created by sumaya alawad on 07/05/1447 AH.
//

import SwiftUI

struct AllReminderCompleted: View {
    var body: some View {
        NavigationView{
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading, spacing: 20) {
                    
                    Text("My plants🌱")
                        .font(.largeTitle)
                        .padding(.horizontal)
                        .bold()
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
                        Button {
                        } label: {
                            Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(.green)
                            .glassEffect()
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
        }
    }
}
            #Preview {
                AllReminderCompleted()
            }
