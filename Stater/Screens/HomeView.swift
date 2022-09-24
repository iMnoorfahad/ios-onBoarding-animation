//
//  HomeView.swift
//  Stater
//
//  Created by Noor Fahad on 20/09/22.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onBoarding") var isOnBoarding:Bool = false;
    @State private var isAnimating:Bool = false
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y:isAnimating ? 35 : -35)
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever()
                        ,value: isAnimating
                    )
                
            }
            TextSubtitleView(text: "The time that leads to mastery is dependent on the intensity of our focus.", color: .secondary, size: .title3,paddingType: .all, paddingSize: 0, fontWeight: .light)
                .opacity(isAnimating ? 1:0)
                .offset(y:isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 0.40), value: isAnimating)
            
            Spacer()
            
            Button(action: {
                withAnimation{
                    playSound(sound: "success", type: "m4a")
                    isOnBoarding = true
                }
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("On Boarding")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .opacity(isAnimating ? 1:0)
            .offset(y:isAnimating ? 0 : 40)
            .animation(.easeOut(duration: 0.40), value: isAnimating)
            Spacer()
        } //: VSTACK
        .onAppear(perform: {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                isAnimating = true
            })
        })
        .preferredColorScheme(.dark)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
