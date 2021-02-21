//
//  DisplayEventList.swift
//  DotrixGames
//
//  Created by Rafal on 17/01/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import SwiftUI
import MapKit

struct DisplayEventList: View {
    
    @State var viewModel: EventListViewModel
    @State var openViewForAddingNewEvent: Bool = false
    
    var body: some View {
        

        ZStack(alignment: .top, content: {
            HeaderView()
                .zIndex(1)
            ScrollView(.vertical, showsIndicators: false,
                content: {
                    
                    ForEach(self.viewModel.events) {event in
                        VStack(spacing: 20) {
                            HStack(spacing: 20) {
                                Image(systemName: "tv")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                
                                Spacer(minLength: 0)
                                
                                Text("\(event.name!)")
                                    .font(.body)
                            }
                                .padding()
                            Text("Event added: 1 hour ago")
                                .font(.caption)
                                .foregroundColor(.gray)

                        }
                    }
                    
//                    List(self.viewModel.events) {event in
//                        HStack {
//                            Text("\(event.name!)")
//                        }
//                    }
                    //.navigationBarTitle(Text("Event List"))
            })
                .padding(.top, 80)
        })
    }
}

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "tv")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            
        Text("User Name")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .kerning(0.5)
        
        Spacer(minLength:0)
            
        Button(action: {
            // here function to open view for adding new event

        },label: {
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .offset(x: -10)
                
        })
            
        Button(action: {
            // search event
        },label: {
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .offset(x: -10)
        })
            
        Button(action: {
            // button to edit profile
        },label: {
            Image(systemName: "person.fill")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .offset(x: -10)
        })
            
            

        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        
        // Divider
        .overlay(
            Divider()
            ,alignment: .bottom
        )
    }
}
// https://blckbirds.com/post/how-to-navigate-between-views-in-swiftui-by-using-an-environmentobject/


struct DisplayEventList_Previews: PreviewProvider {
    static var previews: some View {
        DisplayEventList(viewModel: EventListViewModel())
    }
}

