//
//  MainApp.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct MainApp: View {
    var body: some View {
        TabView{
            EditingMainView()
                .tabItem{
                    Image(systemName: "heart")
                    Text("Editing View")
            }
            ScanningMainView()
                .tabItem{
                    Image(systemName: "checkmark")
                    Text("ScanningMainView")
            }
        }
    }
}

struct MainApp_Previews: PreviewProvider {
    static var previews: some View {
        MainApp()
    }
}
