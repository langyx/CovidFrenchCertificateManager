//
//  EditingGenerationView.swift
//  CovidFrenchCertificateManager
//
//  Created by Yannis Lang on 08/04/2020.
//  Copyright © 2020 Yannis Lang. All rights reserved.
//

import SwiftUI

struct Reason {
    var title   : String
    var code    : String
    var isSelected : Bool = false
}

struct EditingGenerationView: View {
    
    var people : People
    
    
    @ObservedObject var webViewModel : WebViewModel
    
    @State private var validForm = false
    
    init(people : People, webViewModel : WebViewModel) {
        self.people = people
        self.webViewModel = webViewModel
        
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        ZStack{
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                if !validForm {
                    Group {
                        Text("Selectionner vos raisons")
                            .font(.subHeaderTitle)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(0..<self.webViewModel.reasons.count) { reasonIndex in
                                    HStack {
                                        Text(self.webViewModel.reasons[reasonIndex].title)
                                            .padding()
                                            .background(NeoBackground(isHighlighted: self.webViewModel.reasons[reasonIndex].isSelected, shape: RoundedRectangle(cornerRadius: 20)))
                                            .padding([.bottom], 30)
                                            .padding(.top)
                                            .onTapGesture {
                                                self.webViewModel.reasons[reasonIndex].isSelected.toggle()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                Button(action: {
                    self.validForm.toggle()
                }, label: {
                    Text(self.validForm ? "Recommencer" : "Valider")
                })
                    .disabled(self.validForm && !self.webViewModel.didFinishLoading)
                
                if self.validForm {
                    SwiftUIWebView(viewModel: self.webViewModel)
                        .frame(maxWidth: self.webViewModel.didFinishLoading ?  .infinity : 0, maxHeight: self.webViewModel.didFinishLoading ?  .infinity : 0)
                }
                Spacer()
            }
            .padding(self.validForm ? [] : .leading)
            
            .navigationBarTitle("\(people.firstname ?? "")")
            
        }
    }
}

struct EditingGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let peopleTest = People(context: context)
        peopleTest.firstname = "Yannis"
        
        return EditingGenerationView(people: peopleTest, webViewModel: WebViewModel(link: Constants.url, people: peopleTest)).environment(\.managedObjectContext, context)
    }
}
