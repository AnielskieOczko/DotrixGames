//
//  EventDatePickerView.swift
//  DotrixGames
//
//  Created by Rafal on 12/05/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import SwiftUI


struct EventDatePickerView: View {
    
    @Binding var eventStartDate: Date
    @Binding var eventEndDate: Date
    
    var body: some View {

        Group {
            DatePicker("start date: ", selection: $eventStartDate)
            DatePicker("end date: ", selection: $eventEndDate)
        }
    }
}

//struct EventDatePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDatePickerView(eventStartDate: Date(), eventEndDate: Date())
//    }
//}
