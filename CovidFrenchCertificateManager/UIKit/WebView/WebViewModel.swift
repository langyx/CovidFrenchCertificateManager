//
//  WebViewModel.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import Foundation
import SwiftUI

class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    
    @ObservedObject var people : People
    
    @Published var reasons = [
        Reason(title: "Déplacement travail", code: "travail"),
        Reason(title: "Courses", code: "courses"),
        Reason(title: "Santé", code: "sante"),
        Reason(title: "Raison familiale", code: "famille"),
        Reason(title: "Sport/Animaux", code: "sport"),
        Reason(title: "Judidiciare", code: "judiciaire"),
        Reason(title: "Intérêt général", code: "missions"),
    ]
    
    init (link: String, people : People) {
        self.link = link
        self.people = people
    }
}
