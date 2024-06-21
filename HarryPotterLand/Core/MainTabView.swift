//
//  MainTabView.swift
//  HarryPotterLand
//
//  Created by Patka on 18/03/2024.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var favouritesManager: FavouritesManager
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                    NavigationStack {
                        HomeView(homeViewModel: homeViewModel)
                    }
                    .tag(0)
                    
                    NavigationStack {
                        FavouritesView()
                    }
                    
                    .tag(1)
                    .badge(favouritesManager.favouritesCount)
           
                    
                    NavigationStack {
                        SearchView(characters: homeViewModel.characters)
                    }
                    .tag(2)
            }
            ZStack {
                HStack {
                    ForEach(TabbedItems.allCases, id: \.self) { item in
                        Button {
                            selectedTab = item.rawValue
                              
                        } label: {
                            customTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.purple.opacity(0.2))
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
        }
    }

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
                .environmentObject(FavouritesManager(hapticsManager: HapticsManager()))
        }
    }

extension MainTabView {
    
    private func customTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName:imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundStyle(isActive ? .black : .gray)
            }
            Spacer()
        }
        .badge(favouritesManager.favouritesCount)
        .frame(width: isActive ? 180 : 60, height: 60)
        .background(isActive ? .purple.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}
