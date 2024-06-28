//
//  TabbedItems.swift
//  HarryPotterLand
//
//  Created by Patka on 15/05/2024.
//

import Foundation

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case favourites
    case search
    
    var title: String {
        switch self {
        case .home:
            return Constants.Titles.home
        case .favourites:
            return Constants.Titles.fav
        case .search:
            return Constants.Titles.search
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return Constants.Images.homeIcon
        case .favourites:
            return Constants.Images.starFillIcon
        case .search:
            return Constants.Images.searchIcon
        }
    }
}
