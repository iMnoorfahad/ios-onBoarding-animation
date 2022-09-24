//
//  ContentView.swift
//  Stater
//
//  Created by Noor Fahad on 20/09/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onBoarding") var isOnBoarding:Bool = true;
    var body: some View {
        VStack {
            if isOnBoarding {
                OnboardingView()
            }else {
                HomeView()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
