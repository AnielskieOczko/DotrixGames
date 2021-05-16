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
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var eventsNavigationController: EventNavigationController
    
    @ObservedObject var viewModel: EventListViewModel
    
    
    
    var body: some View {

            NavigationView {
                VStack {
                    HeaderViewMyEvents(viewModel: viewModel)
                    .zIndex(1)
                    // TODO: Change filter, to pull data using query with criteria (event owner ID)
//                    List((viewModel.model).filter({ "\($0.ownerId)".contains(loginManager.currentUser?.userId ?? "niezalogowany") }), id:\.id) { event in
//                        NavigationLink(destination: ViewForMyOwnEvents(event: event, viewModel: viewModel)) {
//                            Text("Event: \(event.name!)")
//                            Text("Type: \(event.type!)")
//                            Text("\(event.ownerId)")
//                        }
                    List((viewModel.myEvents), id:\.id) { event in
                        NavigationLink(destination: ViewForMyOwnEvents(event: event, viewModel: viewModel)) {
                            Text("Event: \(event.name!)")
                            Text("Type: \(event.type!)")
                            Text("\(event.ownerId)")
                        }
                }
//                    .onAppear(perform: {
//                        print("RJ say: \(viewModel.myEvents)")
//                    })
                .buttonStyle(PlainButtonStyle())
                .listStyle(GroupedListStyle())
                }
                
            }.padding().navigationViewStyle(StackNavigationViewStyle())

        
    }
}

struct ViewForMyOwnEvents: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State var event: Event
    @State var viewModel: EventListViewModel
    @State var editMode: Bool =  false
    @State var text: String  = ""
    
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
            HStack(spacing: 50) {

                NavigationLink(
                    destination: EditEvent(event: event, viewModel: viewModel),
                    isActive: $editMode,
                    label: {
                        Button(action: {
                            // here function to open view for edit event
                            editMode.toggle()
                        },label: {
                            Text("Edit")
                                .buttonStyle(PlainButtonStyle())
                                .font(.title)
                        })
                    })
                
                Divider()
                //SZxUrDkJf5
                Button(action: {
                    // remove event from event list
                    viewModel.deleteEvent(id: event.id!)
                    
                    
                    
                    presentation.wrappedValue.dismiss()
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
