//
//  AboutView.swift
//  Timer
//
//  Created by Patrick Cunniff on 6/4/23.
//

import SwiftUI

struct AboutView: View {
    var closeWindow: (String) -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    closeWindow("about")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            
            Spacer(minLength: 0)
            
            Image(nsImage: #imageLiteral(resourceName: "test.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("SimplePomato v1.4")
                .padding(.bottom, 10.0)
            Text("Timer apps should not be paywalled. Submit a feature request or bug report and I'll try to get to it as quickly as possible")
            
            Spacer()
            Text("Enter bugs or request features:")
            Link(destination: URL(string: "https://github.com/bilbofroggins/SimplePomato/issues")!) {
                        Text("Github")
                            .foregroundColor(.blue)
                    }
            
            Spacer(minLength: 0)
        }
        .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(closeWindow:{_ in })
    }
}
