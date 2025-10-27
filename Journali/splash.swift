//
//  splash.swift
//  Journaling (hello world)
//
//  Created by alya Alabdulrahim on 28/04/1447 AH.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            // Background gradient that persists
            LinearGradient(
                colors: [
                    Color(red: 20/255, green: 20/255, blue: 32/255),
                    Color.black
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Main content fades in
            MainView()
                .opacity(isActive ? 1 : 0)
                .allowsHitTesting(isActive)
            
            // Splash overlay fades out
            VStack(spacing: 12) {
                Image("BookLogo")
                
                Text("Journali")
                    .font(.system(size: 42, weight: .black, design: .default))
                    .foregroundStyle(.white)
                
                Text("Your thoughts, your story")
                    .foregroundStyle(.white)
            }
            .padding()
            .opacity(isActive ? 0 : 1)
            .allowsHitTesting(false)
        }
       
        .animation(.easeInOut(duration: 0.4), value: isActive)
        .onAppear {
            // Keep splash for 1 second, then transition
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isActive = true
            }
        }
    }
}

#Preview {
    SplashView()
}
