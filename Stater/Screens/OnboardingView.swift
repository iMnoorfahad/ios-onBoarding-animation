//
//  OnboardingView.swift
//  Stater
//
//  Created by Noor Fahad on 20/09/22.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onBoarding") var isOnBoarding:Bool = true;
    
    @State private var buttonWidth:Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset:CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var titleHeading:String = "Share.."
    @State private var feedbackNotification = UINotificationFeedbackGenerator()
    var body: some View {
        ZStack {
            Color("BlueColor")
                .ignoresSafeArea()
            VStack(spacing: 20){
                // :Start Header
                Spacer()
                VStack{
                    Text(titleHeading)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(titleHeading)
                    
                    TextSubtitleView(text: "this is randame text here we are showing it's just normal as we are doing", color: .white, size: .title3,paddingType: .all, paddingSize: 0,fontWeight: .light)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y:isAnimating ? 0 : -40)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                }// :Header End
                
                //Center
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            indicatorOpacity = 0
                                            titleHeading = "Give"
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1.0
                                        titleHeading = "Share..."
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                }//End Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y:20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    ,alignment: .bottom
                )
                
                Spacer()
                
                //Footer
                ZStack{
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2)).padding(8)
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20)
                    HStack{
                        Capsule()
                            .fill(Color("RedColor"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }//:Hstack
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("RedColor"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: 80,height: 80,alignment: .center)
                        .offset(x:buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    withAnimation(Animation.easeOut(duration: 0.8)){
                                        if buttonOffset > buttonWidth / 2 {
                                            feedbackNotification.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnBoarding = false
                                        } else {
                                            feedbackNotification.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                    
                                }
                        )
                        Spacer()
                    }//:HStack
                } //:End Footer
                .frame(width:buttonWidth ,height: 80,alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
            }.padding() //:VSTACK
        }//:ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.light)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
