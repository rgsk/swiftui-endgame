//
//  SampleLoginPage.swift
//  First
//
//  Created by Rahul Gupta on 15/07/23.
//

import SwiftUI

struct SampleLoginPage: View {
    @State var username = ""
    @State var password = ""
    @State var errorUsername = ""
    @State var errorPassword = ""
    
    func onSubmit() {
        // Handle submit button tapped event here
        // For example, you can perform login validation or submit the form data
        print("username: " + username);
        print("password: " + password);
        
        if (username == "") {
            errorUsername = "Username should not be empty";
        } else {
            errorUsername = "";
        }
        
        if (password == "") {
            errorPassword = "Password should not be empty";
        } else {
            errorPassword = "";
        }
    }
    
    var body: some View {
        VStack {
            Text("Login").font(.title)
            VStack {
                Field(label:"Username", isSecure: false, value: $username, error: $errorUsername)
                Field(label:"Password", isSecure: true, value: $password, error: $errorPassword)
            }
            .padding(.all)
            if !errorUsername.isEmpty {
                ErrorMessage(errorMessage: errorUsername)
            }
            if !errorPassword.isEmpty {
                ErrorMessage(errorMessage: errorPassword)
            }
            
            Button(action: {
                // Action to perform when the button is tapped
                onSubmit()
            }) {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

struct ErrorMessage: View {
    var errorMessage: String
    var body: some View {
        
            Text(errorMessage)
                .font(.subheadline)
                .foregroundColor(.red)
                .padding(.top, 8)

        
    }
}

struct Field: View {
    var label: String
    var isSecure: Bool
    @Binding var value: String
    @Binding var error: String
    
    var body: some View {
        if isSecure {
            SecureField(label, text: $value)
                .modifier(FieldModifier(error: $error))
        } else {
            TextField(label, text: $value)
                .modifier(FieldModifier(error: $error))
        }
    }
}

struct FieldModifier: ViewModifier {
    @Binding var error: String
    func body(content: Content) -> some View {
        content
            .padding(.all, 12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(error.isEmpty ? Color.clear : Color.red, lineWidth: 0.8)
            )
    }
}

struct SampleLoginPage_Previews: PreviewProvider {
    static var previews: some View {
        SampleLoginPage()
    }
}
