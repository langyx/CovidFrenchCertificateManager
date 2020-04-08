//
//  ScanningMainView.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct ScannedData {
    public var lastname: String?    = ""
    public var firstname: String?   = ""
    public var born: String?        = ""
    public var adress: String?      = ""
    public var date: String?        = ""
    public var reasons: String?     = ""
    public var valid: Bool = false
}

struct ScanningMainView: View {
    
    @State private var scannedData = ScannedData()
    
    var body: some View {
        ZStack{
            QRCodeScan(scannedData: self.$scannedData)
            if self.scannedData.valid {
                VStack{
                    Text(self.scannedData.lastname ?? "")
                    Text(self.scannedData.firstname ?? "")
                    Text(self.scannedData.born ?? "")
                    Text(self.scannedData.adress ?? "")
                    Text(self.scannedData.date ?? "")
                    Text(self.scannedData.reasons ?? "")
                    Button(action: {
                        self.scannedData.valid.toggle()
                    }, label: {
                        Text("Fermer")
                    })
                }
                .padding()
                .background(NeoBackground(isHighlighted: false, shape: RoundedRectangle(cornerRadius: 20)))
            }
        }
    }
}

struct ScanningMainView_Previews: PreviewProvider {
    static var previews: some View {
        ScanningMainView()
    }
}
