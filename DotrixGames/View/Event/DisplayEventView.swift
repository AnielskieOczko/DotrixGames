//
//  DisplayEvent.swift
//  DotrixGames
//
//  Created by Rafal on 21/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//
//// https://blckbirds.com/post/how-to-navigate-between-views-in-swiftui-by-using-an-environmentobject/

import SwiftUI
import Parse

struct MainView: View {
    
    //@State var showView = false
    
    @ObservedObject var viewModel: EventListViewModel
    //@ObservedObject var viewModel: EventListViewModel
//    @State var events = [
//        Event(id: 1, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix"),
//        Event(id: 2, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix"),
//        Event(id: 3, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix")]
    


    var body: some View {

            NavigationView {
                VStack {
                    HeaderView(viewModel: viewModel)
                    .zIndex(1)
                    List(viewModel.model, id:\.id) { event in
                        NavigationLink(destination: EventView(event: event, viewModel: viewModel)) {
                            Text("Event: \(event.name!)")
                            //Text("Type: \(event.type!)")
                            Text("\(event.owner)")
                        }
                        .font(.footnote)
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

struct EventView: View {
    @State var event: Event
    @State var viewModel: EventListViewModel
    
    let dateFormatter = DateFormatter()
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            VStack {
                HStack (spacing: 20) {
                    Text("Name: ")
                    Text(event.name!)
                }
            }
            VStack(alignment: .leading) {
                
                Group {
                    HStack (spacing: 20) {
                        Text("OwnerID: ")
                        Text(event.ownerId)
                    }
                    HStack (spacing: 20) {
                        Text("ID: ")
                        Text(event.id!) // blad gdy po dodaniu ewentu od razu otwierasz okno ewentu, ID z serwera jeszcze sie nie zaciagnelo
                    }
                    HStack (spacing: 20) {
                        Text("type: ")
                        Text(event.type!)
                    }
    //                Divider()
    //                HStack (spacing: 20) {
    //                    Text("mapCoordinates: ")
    //                    Text(event.mapCoordinates!)
    //                        .offset(y: 0)
    //                }
    //                .padding(.bottom)
                    Divider()
                    HStack (spacing: 20) {
                        Text("Number of players: ")
                        Text(String(event.numberOfPlayers!))
                            
                    }
                    Divider()
                    
                    HStack (spacing: 20) {
                        Text("Description: ")
                        Text(event.description!)
                    }
                    Divider()
                    
                    HStack (spacing: 20) {
                        Text("GameName: ")
                        Text(event.gameName!)
                    }
                    Divider()
                }

                Divider()

                
                HStack (spacing: 20) {
                    Text("Organizators")
                    Text(event.organizators!)
                }
                Divider()
                
//                HStack (spacing: 20) {
//
//                    Text("Date")
//                    Text(dateFormatter.string(from: event.date!) )
//                }
//                Divider()
                
//                HStack (spacing: 20) {
//                    Text("Participants")
//                    Text(event.participants!)
//                }
//                Divider()
                
                HStack (spacing: 20) {
                    Text("Owner")
                    Text(event.owner)
                }
                Divider()
                
                
            }
            .padding()

//            HStack {
//                VStack (alignment: .leading) {
//                    Text("Adress: ")
//                    MapDisplayView()
//                }
//                .frame(width: 400, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//
//            }
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



struct HeaderView: View {
    
    @State var viewModel: EventListViewModel
    @State var showAddNewEventView: Bool = false
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: "book")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)

        Text("Event List")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .kerning(0.5)

        Spacer(minLength:0)

            
        NavigationLink(
            destination: AddNewEventView(viewModel: viewModel),
            isActive: $showAddNewEventView,
            label: {
                Button(action: {
                    // here function to open view for adding new event
                    showAddNewEventView.toggle()
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


//struct DisplayMainView3: PreviewProvider {
//    static var previews: some View {
//        EventView(event: Event(name: "newEventTest", type: "unknown"),viewModel: EventListViewModel())
//    }
//}


struct DisplayMainView: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: EventListViewModel())
        //EventView(event: Event(id: 1, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix"))
    }
}

