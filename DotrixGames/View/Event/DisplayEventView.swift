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
import Foundation

struct MainView: View {
    
    //@State var showView = false
    
    @ObservedObject var viewModel: EventListViewModel

    var body: some View {

            NavigationView {
                VStack {
                    HeaderView(viewModel: viewModel)
                    .zIndex(1)
                    List(viewModel.model, id:\.id) { event in
                        NavigationLink(destination: EventView(event: event, viewModel: viewModel)) {
                            SingleLineInListView(event: event)
//                            Text("Event: \(event.name!)")
//                            //Text("Type: \(event.type!)")
//                            Text("\(event.owner)")
                        }
                        .font(.footnote)
                }
                    .onAppear(perform: {
                        //print(viewModel.model)
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
    @State var returnTxt: String = ""

    
    var body: some View {
        
        VStack(spacing: 20) {
            rowView(labelText: "Name", valueText: event.name)
                .font(.system(size: 20))
            

            VStack(alignment: .leading) {
                
                rowView(labelText: "Owner Id: ", valueText: event.ownerId)
                rowView(labelText: "Event Id: ", valueText: event.id)

                Group {
                    rowView(labelText: "Type: ", valueText: event.type)


                    Divider()
                    
                    rowView(labelText: "Players  signed in: ", valueText: "1 / \(event.numberOfPlayers!)")
                    Divider()
                    
                    HStack (spacing: 20) {
                        Text("Description: ")
                        MultiLineTF(txt: event.description!, editeEnabled: false, returnTxt: $returnTxt)
                            .border(Color.black.opacity(0.5), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    }.frame(maxWidth: .infinity, minHeight:   100, maxHeight: .infinity)
                    
                    //Divider()
                    
                    HStack (spacing: 20) {
                        Text("GameName: ")
                        Text(event.gameName!)
                    }
                }

                Divider()
                
                HStack (spacing: 20) {

                    Text("Start date")
                    Text(viewModel.converDateToString(date: event.startDate!))
                }
                
                HStack (spacing: 20) {

                    Text("End date")
                    Text(viewModel.converDateToString(date: event.startDate!))
                }
                
                Divider()
                

                HStack (spacing: 20) {
                    Text("Organizators")
                    Text(event.organizators!)
                }
                
                HStack (spacing: 20) {
                    Text("Owner")
                    Text(event.owner)
                }
                

                Divider()
                
                
            }
            .padding()

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

struct rowView: View {
    
    var labelText: String
    @State var valueText: String?
    
    var body: some View {
        HStack (spacing: 20) {
            Text(labelText)
                .fontWeight(.bold)
            Text(valueText!)
                .fontWeight(.bold)
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
struct SingleLineInListView: View {
    
    @State var event: Event
    
    var body: some View {
        VStack {
            HStack(spacing:20) {
                Image(systemName: "moon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                VStack {
                    Text(event.name!)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .kerning(0.5)
                }
                .padding(.leading)
                
                Spacer(minLength:0)
                Text(event.type!)
                    .fontWeight(.heavy)
                    .kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)

            }
            .padding()

            
            HStack(spacing: 20) {
                Spacer(minLength: 0)
                Text("created 1 hour ago")
                    .foregroundColor(.gray)
                    .padding(.trailing)
                
            }
            .padding(.leading)
        }
        



        
    }
}
//struct DisplaySingleLineView: PreviewProvider {
//    static var previews: some View {
//        singleLineInListView(event: Event(id: "1", name: "Dota day", type: "Tournament", owner: "owner", ownerId: "xcv"))
//        //EventView(event: Event(id: 1, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix"))
//    }
//}


struct DisplayMainView: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: EventListViewModel())
        //EventView(event: Event(id: 1, name: "Dota LAN Event", numberOfPlayers: 100, description: "Test description Test description Test description Test description Test description Test description", gameName: "Dota", organizators: "Dotrix"))
    }
}

