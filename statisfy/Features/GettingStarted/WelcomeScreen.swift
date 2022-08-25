//
//  WelcomeScreen.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-25.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Color(UIColor.backgroundColor)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Welcome")
                    .font(.welcomeFont)
                    .textColor(.spotifyWhite)
                    .padding()
                Text("Tap the get started button to link your account and view your stats")
                    .font(.welcomeSubtitleFont)
                    .textColor(.spotifyWhite)
                    .padding(EdgeInsets(top: 4, leading: 32, bottom: 4, trailing: 32))
                Spacer()
                Button("Get Started") {
                    viewModel.loginStatus = .inprogress
                }
                .padding(EdgeInsets(top: 12, leading: 64, bottom: 12, trailing: 64))
                .background(Color(UIColor.spotifyGreen))
                .foregroundColor(Color(UIColor.spotifyWhite))
                .font(Font(uiFont: UIFont.tableCellFontBolded))
                .cornerRadius(8)
                Button("Demo the app") {
                    viewModel.informationType = .demo
                }
                .foregroundColor(Color(UIColor.spotifyWhite))
                .font(Font(uiFont: UIFont.tableCellFontBolded))
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 48, trailing: 0))
            }
        }.fullScreenCover(isPresented: $viewModel.showSheet) {
            AuthScreen(viewModel: viewModel)
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen(viewModel: LoginViewModel())
    }
}
