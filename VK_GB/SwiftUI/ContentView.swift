//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Павел Черняев on 28.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var login: String = ""
    @State var password: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Image("vk-logo")
                        .resizable()
                        .frame(maxWidth: 50, maxHeight: 50)
                        .cornerRadius(12)
                    Text("вконтакте")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                Text("Для продолжения вам необходимо войти ВКонтакте")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(Color.gray)
                Text("Телефон или email:")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .padding(.top, 24)
                TextField("", text: $login)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Пароль")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .padding(.top, 8)
                
                SecureField("", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Button(action: {
                        print("ok")
                    }, label: {
                        Text("Войти")
                            .font(.title3)
                            .foregroundColor(Color.white)
                            
                    })
                    .padding(.init(top: 8,
                                   leading: 16,
                                   bottom: 8,
                                   trailing: 16))
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    Button(action: {
                        print("cancel")
                    }, label: {
                        Text("Отмена")
                            .font(.title3)
                    })
                    .padding(.leading)
                    Spacer()
                }
                .padding(.top)
                Spacer()
            }
            .padding(.init(top: 8,
                           leading: 8,
                           bottom: 8,
                       trailing: 8))
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

extension UIApplication {
    func endEditing () {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
