//
//  TextSubtitleView.swift
//  Stater
//
//  Created by Noor Fahad on 24/09/22.
//

import SwiftUI

struct TextSubtitleView: View {
    @State var text:String
    @State var color:Color
    @State var size:Font
    @State var paddingType:Edge.Set
    @State var paddingSize:CGFloat
    @State var fontWeight:Font.Weight
    
    var body: some View {
        Text(self.text)
            .foregroundColor(color)
            .font(size)
            .fontWeight(fontWeight)
            .multilineTextAlignment(.center)
            .padding(paddingType,paddingSize)
    }
}

struct TextSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        TextSubtitleView(text: "this is randame text here we are showing it's just normal as we are doing", color:Color("BlueColor"),size:.title3,paddingType: .all, paddingSize: 10,fontWeight: .bold)
    }
}
