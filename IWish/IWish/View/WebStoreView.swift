//
//  WebStoresView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 8/14/22.
//

import SwiftUI

struct WebStoreView: View {
    var layout =
        Array(repeating: GridItem(.flexible()), count: 2)
   
    @State var searchText = ""
    @State var searching = false
    @State private var isEditing = false
    
    var body: some View {
        NavigationView{
        VStack{
            Text("Need an idea for your wish?")
                .font(.custom("Kanit-Bold", size: 24))
                .padding()
        ZStack {
            Rectangle().fill(.ultraThinMaterial)
                HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search..", text: $searchText)
                                .autocapitalization(.none)
                                .font(.callout)
                        } .foregroundColor(Color.blue)
                            .padding(.leading, 13)
        
                    } .frame(height: 40)
                        .cornerRadius(13)
                        .padding(.bottom, 20)
        ScrollView{
        LazyVGrid(columns: layout, spacing: 20 ){
            ForEach(sData.filter({"\($0)".contains(searchText.lowercased()) || searchText.isEmpty})) { i in
            VStack{
                Link(destination: URL(string: i.storeURL)!, label: {
                    Image(i.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
            })
                    }
                }
            }
        }
    }
            Spacer()
        }
    }
}

struct WebStoresView_Previews: PreviewProvider {
    static var previews: some View {
        WebStoreView()
    }
}
