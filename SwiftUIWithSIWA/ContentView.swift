//
//  ContentView.swift
//  SwiftUIWithSIWA
//
//  Created by hiraoka on 2022/06/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SampleView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI
import AuthenticationServices

struct SampleView: View {
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""
    @Environment(\.colorScheme) var colorScheme

    var isDarkMode: Bool {
        colorScheme == .dark
    }

    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { authResults in
                switch authResults {
                case .success(let authResults): break
                    // AppleIDログイン完了時にはしる処理。サーバにAuth情報を保存したりする。
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.isShowAlert.toggle()
                }
            }
            .signInWithAppleButtonStyle(isDarkMode ? .white : .black)
            .frame(width: 224, height: 40)
        }
        .alert(isPresented: $isShowAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
