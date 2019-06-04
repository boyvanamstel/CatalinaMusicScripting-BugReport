//
//  ContentView.swift
//  CatalinaMusicBridge
//
//  Created by Boy van Amstel on 04/06/2019.
//  Copyright © 2019 Danger Cove. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        Text("Hello World")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
