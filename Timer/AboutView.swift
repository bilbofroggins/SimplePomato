//
//  AboutView.swift
//  Timer
//
//  Created by Patrick Cunniff on 6/4/23.
//

import SwiftUI

struct AboutView: View {
    @State private var issueTitle = ""
    @State private var issueBody = "Desciption of bug/feature or general compliments"
    @State private var submitStatus = "Submitting..."
    
    @Environment(\.controlActiveState) private var controlActiveState
    
    let repoOwner = "bilbofroggins"
    let repoName = "SimplePomato"
    let githubToken = "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"
    
    func submitIssue() {
        submitStatus = "Submitting..."
        guard let url = URL(string: "https://api.github.com/repos/\(repoOwner)/\(repoName)/issues") else {
            return
        }
        
        let issue = [
            "title": issueTitle,
            "body": issueBody
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: issue)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(githubToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error submitting issue: \(error.localizedDescription)")
                submitStatus = "Error, please add an issue here: https://github.com/bilbofroggins/SimplePomo/issues"
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    DispatchQueue.main.async {
                        submitStatus = "Thanks for your submission!"
                    }
                    print("Issue submitted successfully")
                } else {
                    print("Failed to submit issue. Status code: \(httpResponse.statusCode)")
                    submitStatus = "Error, please add an issue here: https://github.com/bilbofroggins/SimplePomo/issues"
                }
            }
        }
        .resume()
    }

    var body: some View {
        VStack {
            if submitStatus != "" {
                VStack {
                    Text(submitStatus)
                }
                .padding()
            } else {
                VStack {
                    Text("SimplePomato v0.1.0")
                    Text("Timer apps should not be paywalled. Submit a feature request or bug report and I'll try to get to it as quickly as possible")
                    TextField("Title", text: $issueTitle)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextEditor(text: $issueBody)
                        .padding()
                        .border(Color.gray)
                        .padding(.bottom)
                    
                    Button(action: submitIssue) {
                        Text("Submit")
                    }
                }
                .padding()
            }
        }
        .onChange(of: controlActiveState) { newValue in
            switch newValue {
            case .key, .active:
                break
            case .inactive:
                submitStatus = ""
                issueTitle = ""
                issueBody = "Desciption of bug/feature or general compliments"
            @unknown default:
                break
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
