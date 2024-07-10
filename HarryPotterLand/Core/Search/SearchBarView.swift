//
//  SearchBarView.swift
//  HarryPotterLand
//
//  Created by Patka on 21/06/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    var performAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: -2) {
            searchBarSection
        }
    }
}

extension SearchBarView {
    
    private var searchBarSection: some View {
        HStack {
            Image(systemName: Constants.Images.searchIcon)
                .foregroundStyle( .white)
                .opacity(searchText.isEmpty ? 1 : 0)
            TextField(Constants.Titles.searchByNameOrTitle, text: $searchText)
                .autocorrectionDisabled()
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
                .onChange(of: searchText) { newValue in
                    searchText = newValue
                    performAction?()
                }
                .tint(.white)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(Constants.Colors.hufflepuffLightBrown).opacity(0.4))
                .shadow(radius: 1)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
        )
        .shadow(radius: 6)
        .padding()
    }
}

#Preview {
    ZStack {
        Background()
        
        SearchBarView(searchText: .constant(""))
    }
}
