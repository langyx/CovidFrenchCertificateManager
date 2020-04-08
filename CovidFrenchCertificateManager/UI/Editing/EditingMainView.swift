//
//  EditingMainView.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct EditingMainCell : View {
    
    var people : People
    
    var body: some View {
        VStack {
            HStack{
                Text(people.firstname ?? "")
                    .font(.subHeaderTitle)
                Text(people.lastname ?? "")
                    .font(.subHeaderTitle)
                Spacer()
                Image(systemName: "chevron.right.circle")
            }
        }
        .padding()
        .background(NeoBackground(isHighlighted: false, shape: RoundedRectangle(cornerRadius: 20)))
        .frame(maxWidth : .infinity, maxHeight : 100)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

struct EditingMainView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: People.entity(), sortDescriptors: [
            NSSortDescriptor(keyPath: \People.firstname, ascending: true)
        ]
        
    ) var peoples: FetchedResults<People>
    
    @State private var showAddView = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
    }

    
    var body: some View {
        NavigationView{
            ZStack{
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(self.peoples, id:\.self){ people in
                        NavigationLink(destination: EditingGenerationView(people: people, webViewModel:
                            WebViewModel(link: Constants.url, people: people))){
                            EditingMainCell(people: people)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .sheet(isPresented: $showAddView, content: {
                EditingAddProfileView(isShowed: self.$showAddView).environment(\.managedObjectContext, self.managedObjectContext)
            })
                .navigationBarTitle("Editing")
                .navigationBarItems(trailing: HStack{
                    Button(action: {
                        self.showAddView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(Font.headerTitleFont)
                            .foregroundColor(.white)
                            .background(NeoBackground(isHighlighted: false, shape: Circle()))
                    })
                })
        }
    }
}

struct EditingMainView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let newTestPeople = People(context: context)
        
        newTestPeople.firstname = "Yannis"
        newTestPeople.lastname = "Lang"
        
        
        return EditingMainView().environment(\.managedObjectContext, context)
    }
}
