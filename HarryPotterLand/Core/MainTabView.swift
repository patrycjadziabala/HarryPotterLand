//
//  MainTabView.swift
//  HarryPotterLand
//
//  Created by Patka on 18/03/2024.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var favouritesManager: FavouritesManager
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: Constants.Images.homeIcon)
                Text(Constants.Titles.home)
            }
            
            NavigationStack {
                FavouritesView()
            }
            .tabItem {
                Image(systemName: Constants.Images.starFillIcon)
                Text(Constants.Titles.fav)
            }
            .badge(favouritesManager.favouritesCount)
            
            NavigationStack {
                SearchView(searchViewModel: SearchViewModel())
            }
            .tabItem {
                Image(systemName: Constants.Images.searchIcon)
                Text(Constants.Titles.search)
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(FavouritesManager(hapticsManager: HapticsManager()))
    }
}
