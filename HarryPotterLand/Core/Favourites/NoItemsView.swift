//
//  NoItemsView.swift
//  HarryPotterLand
//
//  Created by Patka on 22/03/2024.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                topSection
                addCharacters
                addMovies
            }
            .padding(.horizontal)
            .onAppear(perform: {
                addAnimation()
            })
        }
        .background(Color(Constants.Colors.color_blue)
            .opacity(0.4))
    }
}

#Preview {
    NoItemsView()
}

extension NoItemsView {
    
    private var topSection: some View {
        VStack (spacing: 20) {
            Text("No favourites yet 🫣")
                .font(.title)
                .fontWeight(.bold)
            Text("Add characters and movies to your favourites")
                .font(.caption)
                .fontWeight(.medium)
                .padding(.bottom, 10)
        }
    }
    
    private var addMovies: some View {
        NavigationLink {
            //MoviesList
        } label: {
            Text("Add Movies")
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(animate ? Color(Constants.Colors.color_canary) : Color(Constants.Colors.color_gold))
                .cornerRadius(30)
        }
        .padding(.horizontal, animate ? 70 : 90)
        .shadow(
            color: animate ? Color(Constants.Colors.color_darkBlue).opacity(0.5) : Color(Constants.Colors.color_darkBlue).opacity(0.7),
            radius: animate ? 30 : 10,
            y: animate ? 75 : 10)
        .scaleEffect(animate ? 1.1 : 1.0)
        .offset(y: animate ? -5 : 0)
    }
    
    private var addCharacters: some View {
        NavigationLink {
            //CharactersList
        } label: {
            Text("Add Characters")
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(animate ? Color(Constants.Colors.color_canary) : Color(Constants.Colors.color_gold))
                .cornerRadius(30)
        }
        .padding(.horizontal, animate ? 70 : 90)
        .shadow(
            color: animate ? Color(Constants.Colors.color_darkBlue).opacity(0.5) : Color(Constants.Colors.color_darkBlue).opacity(0.7),
            radius: animate ? 30 : 10,
            y: animate ? 75 : 10)
        .scaleEffect(animate ? 1.1 : 1.0)
        .offset(y: animate ? -5 : 0)
        .padding(.bottom, 15)
    }
    
    func addAnimation() {
        guard !animate else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}
