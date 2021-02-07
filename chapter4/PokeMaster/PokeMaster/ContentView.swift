//
//  ContentView.swift
//  PokeMaster
//
//  Created by mtAdmin on 2021/2/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PokemonInfoRow()
    }
}

struct PokemonInfoRow: View {
    
    let model = PokemonViewModel.sample(id: 1)
    
    var body: some View {
        VStack {
            HStack {
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 4)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(model.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 12)
            
            HStack(spacing: 12) {
                Spacer()
                Button(action: {
                    print("Fav")
                }) {
                    Image("img")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Button(action: {
                    print("Panel")
                }) {
                    Image("img")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Button(action: {
                    print("Web")
                }) {
                    Image("img")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
        }
        .background(Color.green)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
