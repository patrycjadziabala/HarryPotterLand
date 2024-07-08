//
//  MainTabView.swift
//  HarryPotterLand
//
//  Created by Patka on 18/03/2024.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var favouritesManager: FavouritesManager
    @StateObject var homeViewModel: HomeViewModel
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeView(homeViewModel: homeViewModel)
                }
                .tag(0)
                .toolbarBackground(.hidden, for: .navigationBar, .tabBar)
                
                NavigationStack {
                    FavouritesView()
                }
                .tag(1)
                
                NavigationStack {
                    SearchView(characters: homeViewModel.characters, movies: homeViewModel.movies)
                }
                .tag(2)
                .toolbarBackground(.hidden, for: .navigationBar, .tabBar)
            }
            
            ZStack {
                HStack {
                    ForEach(TabbedItems.allCases, id: \.self) { item in
                        Button {
                            selectedTab = item.rawValue
                        } label: {
                            customTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue), badgeCount: item == .favourites ? favouritesManager.favouritesCount : 0)
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(Color(Constants.Colors.hufflepuffDarkBrown).opacity(0.9))
            .cornerRadius(35)
            .padding(.horizontal, 20)
            .padding(.bottom, -20)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(
            homeViewModel: HomeViewModel(
                imageLoader: ImageLoaderManager(),
                apiManager: APIManager()
            )
        )
            .environmentObject(FavouritesManager(hapticsManager: HapticsManager()))
    }
}

extension MainTabView {
    
    private func customTabItem(imageName: String, title: String, isActive: Bool, badgeCount: Int) -> some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 10) {
                Spacer()
                Image(systemName: imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(isActive ? .black : .gray)
                    .shadow(radius: 10)
                    .frame(width: 25, height: 25)
                
                if isActive {
                    Text(title)
                        .font(.system(size: 17))
                        .foregroundStyle(isActive ? .white : .gray)
                        .shadow(radius: 10)
                }
                Spacer()
            }
            .frame(width: 60, height: 60)
            .padding(.horizontal)
            .background(isActive ? Color(Constants.Colors.ravenclawGrey).opacity(0.9) : .clear)
            .cornerRadius(30)
            
            if badgeCount > 0 {
                Text("\(badgeCount)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: -7, y: 6)
            }
        }
    }
}
