//
//  DisplayEvent.swift
//  DotrixGames
//
//  Created by Rafal on 21/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//


import SwiftUI
import Parse

struct MainView: View {
    
    

    @State var events = [
        Event(id: 1, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix"),
        Event(id: 2, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix"),
        Event(id: 3, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix")]

    var body: some View {

            NavigationView {
                VStack {
                HeaderView()
                    .zIndex(1)
                List(events) { event in
                        NavigationLink(destination: EventView(event: event)) {
                            Text("Event \(event.id)")
                        }
                }
                .buttonStyle(PlainButtonStyle())
                .listStyle(GroupedListStyle())
                }
                
            }.navigationViewStyle(StackNavigationViewStyle())

        
    }
}

struct EventView: View {
    @State var event: Event
    
    var body: some View {
        
        VStack(spacing: 20) {
            HeaderView2()

            HStack(spacing: 100){
                Image(systemName: "tv")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("\(event.name!)")
                    .font(.title)
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                
                HStack (spacing: 20) {
                    Text("Game Name: ")
                    Text(event.gameName!)
                }
                Divider()
                HStack (spacing: 20) {
                    Text("Event Description: ")
                    Text(event.description!)
                        .offset(y: 0)
                }
                .padding(.bottom)
                Divider()
                HStack (spacing: 20) {
                    Text("Max player number: ")
                    Text(String(event.numberOfPlayers!))
                        
                }
                Divider()
                HStack (spacing: 20) {
                    Text("Organizator: ")
                    Text(event.organizators!)
                }
                Divider()
                
            }
            .padding()
            
            HStack {
                VStack (alignment: .leading) {
                    Text("Adress: ")
                    MapDisplayView()
                }
                .frame(width: 400, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }
            Button(action: {
                // action to add user to event list
            }, label: {
                Text("Sign In")
                    .buttonStyle(PlainButtonStyle())
                    .font(.title)
            })


            Spacer(minLength: 0)

            
            
            .font(.body)

        .padding()
        Text("Event added: 1 hour ago")
        .font(.caption)
        .foregroundColor(.gray)
        }
    }
}



struct HeaderView2: View {
    var body: some View {
        HStack(spacing: 20){

            
        Text("User Name")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .kerning(0.5)
        
        Spacer(minLength:0)
            
            
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
        .padding(.vertical, 10)
        
        // Divider
        .overlay(
            Divider()
            ,alignment: .bottom
        )
    }
}











struct DisplayMainView: PreviewProvider {
    static var previews: some View {
        MainView()
        //EventView(event: Event(id: 1, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix"))
    }
}

