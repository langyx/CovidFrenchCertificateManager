//
//  QRCodeScan.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct QRCodeScan: UIViewControllerRepresentable {
    
    @Binding var scannedData : ScannedData
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> QRCodeScanVC {
        let vc = QRCodeScanVC()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ vc: QRCodeScanVC, context: Context) {
    }
    
    class Coordinator: NSObject, QRCodeScannerDelegate {
        
        func codeDidFind(_ code: String) {
            let explodeData = code.split(separator: ";")
            
            for info in explodeData {
                let keyValue = info.split(separator: ":")
                var key = keyValue[0]
                var value = keyValue[1]
                key.removeFirst()
                value.removeFirst()
                
                switch key {
                case "Nom":
                    self.parent.scannedData.lastname = String(value)
                case "Prenom":
                    self.parent.scannedData.firstname = String(value)
                case "Naissance":
                    self.parent.scannedData.born = String(value)
                case "Adresse":
                    self.parent.scannedData.adress = String(value)
                case "Sortie":
                    self.parent.scannedData.date = String(value)
                case "Motifs":
                    self.parent.scannedData.reasons = String(value)
                default:
                    print(key)
                    continue
                }
            }
            
            self.parent.scannedData.valid = true
        }
        
        var parent: QRCodeScan
        
        init(_ parent: QRCodeScan) {
            self.parent = parent
        }
    }
}

