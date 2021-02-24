//
//  ContentView.swift
//  Nabo_AWS_POC
//
//  Created by Rishab Dulam on 2/24/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var imageLocation = ""
    @State var buttonLabel = "Knock knock"
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: imageLocation)).resizable()
                .frame(width: 300, height: 300)
                .clipShape(Rectangle())
            
            Button(action: {
                GatewayAdapter().fetchImages {(result) in
                    switch result {
                    case .success(let images):
                        imageLocation = images.location
                        buttonLabel = "how you doin!"
                        print("Fetched image location \(imageLocation)")
                    case .failure(let error):
                        print(error)
                    }
                }
            }, label: {

                Text(buttonLabel)
            })
            .frame(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .border(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
            
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
