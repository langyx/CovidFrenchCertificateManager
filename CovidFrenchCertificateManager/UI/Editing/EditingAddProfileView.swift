//
//  EditingAddProfileView.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct EditingAddProfileView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var isShowed : Bool
    
    @State private var firstName    : String = ""
    @State private var lastName     : String = ""
    @State private var bornCity     : String = ""
    @State private var bornDate     : String = ""
    
    @State private var liveCity     : String = ""
    @State private var adress       : String = ""
    @State private var zip          : String = ""
    
    var body: some View {
        Form{
            Text("Nouveau")
            
            Section(header: Text("Info perso"), content: {
                TextField("prénom", text: $firstName)
                TextField("nom", text: $lastName)
                TextField("lieu de naissance", text:
                    $bornCity)
                TextField("date de naissance", text:
                $bornDate)
            })
            
            Section(header: Text("Lieu de vie"), content: {
                TextField("ville", text: $liveCity)
                TextField("code postal", text: $zip)
                TextField("adresse", text:
                    $adress)
            })
            
            Button(action: {
                let newPeople = People(context: self.managedObjectContext)
                
                newPeople.firstname = self.firstName
                newPeople.lastname = self.lastName
                newPeople.bornCity = self.bornCity
                newPeople.bornDate = self.bornDate
                
                newPeople.city = self.liveCity
                newPeople.zip = self.zip
                newPeople.adress = self.adress
                
                do {
                    try self.managedObjectContext.save()
                    self.isShowed.toggle()
                } catch {
                    print("error")
                }
                
                
            }, label: {
                Text("Valider")
            })
        }
    }
}

struct EditingAddProfileView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return EditingAddProfileView(isShowed: .constant(false)).environment(\.managedObjectContext, context)
    }
}
