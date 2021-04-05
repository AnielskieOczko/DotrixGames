//
//  MyEventsList.swift
//  DotrixGames
//
//  Created by Rafal on 28/03/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation
import SwiftUI


struct MyEventsView: View {
    
    //@State var showView = false
    @EnvironmentObject var loginManager: AuthorizaionManager
    @ObservedObject var viewModel: EventListViewModel
    
    var body: some View {

            NavigationView {
                VStack {
                    HeaderViewMyEvents(viewModel: viewModel)
                    .zIndex(1)
                    List((viewModel.model).filter({ "\($0.ownerId)".contains(loginManager.currentUser?.userId ?? "niezalogowany") }), id:\.id) { event in
                        NavigationLink(destination: ViewForMyOwnEvents(event: event, viewModel: viewModel)) {
                            Text("Event: \(event.name!)")
                            Text("Type: \(event.type!)")
                            Text("\(event.ownerId)")
                        }
                }
                    .onAppear(perform: {
                        print(viewModel.model)
                    })
                .buttonStyle(PlainButtonStyle())
                .listStyle(GroupedListStyle())
                }
                
            }.navigationViewStyle(StackNavigationViewStyle())

        
    }
}

struct ViewForMyOwnEvents: View {
    @State var event: Event
    @State var viewModel: EventListViewModel
    @State var editMode: Bool =  false
    
    var body: some View {
        
        VStack(spacing: 20) {
            //HeaderViewMyEvents(viewModel: viewModel)

            HStack(spacing: 100){
                Image(systemName: "tv")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("\(event.name!)")
                    .font(.title)
            }
            
            Divider()
            if !editMode {
                VStack(alignment: .leading) {
                    
                    HStack (spacing: 20) {
                        Text("ID: ")
                        Text(event.id!)
                    }
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
            }
            else {
                VStack(alignment: .leading) {
                    
                    HStack (spacing: 20) {
                        Text("ID: ")
                        Text(event.id!)
                    }
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
            }
            
            HStack {
                VStack (alignment: .leading) {
                    Text("Adress: ")
                    MapDisplayView()
                }
                .frame(width: 400, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }
            
            HStack(spacing: 50) {
                Button(action: {
                    // take me to edit event view
                }, label: {
                    Text("Edit")
                        .buttonStyle(PlainButtonStyle())
                        .font(.title)
                })
                
                Divider()
                
                Button(action: {
                    // remove event from event list
                }, label: {
                    Text("Remove")
                        .buttonStyle(PlainButtonStyle())
                        .font(.title)
                })
            }
            
            Spacer(minLength: 0)

            
            
            .font(.body)

        .padding()
        Text("Event added: 1 hour ago")
        .font(.caption)
        .foregroundColor(.gray)
        }
    }
}

struct HeaderViewMyEvents: View {
    @EnvironmentObject var loginManager: AuthorizaionManager
    @State var viewModel: EventListViewModel
    @State var showAddNewEventView: Bool = false
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "book")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            
            //Text("\(loginManager.currentUser?.login ?? "niezalogowany")")
            Text("\(loginManager.currentUser?.userId ?? "niezalogowany")")
            .font(.headline)
            .fontWeight(.bold)
            //.foregroundColor(.black)
            .kerning(0.5)

        Spacer(minLength:0)

        NavigationLink(
            destination: AddNewEventView(viewModel: viewModel),
            isActive: $showAddNewEventView,
            label: {
                Button(action: {
                    // here function to open view for adding new event
                    showAddNewEventView = true
                },label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .offset(x: -10)

                })
            })
            
        Button(action: {
            // search event
        },label: {
            Image(systemName: "magnifyingglass")
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

struct DisplayMainView2: PreviewProvider {
    static var previews: some View {
        MyEventsView(viewModel: EventListViewModel())
    }
}
