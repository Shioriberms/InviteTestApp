//
//  WebService.swift
//  InviteTest
//
//  Created by user210003 on 12/4/21.
//

import Foundation

class WebService : NSObject
{
    // should be rep
    let urlTeams = "https://samplesample.ccc"
    let decoder = JSONDecoder()
    
    func getUser(teamsID : String, completion : @escaping (Team) -> ())  {
        
        //make extentions for below if has time
        let endpoint = "teams/" + teamsID
        var urlRequest = URLRequest(url: URL(string: urlTeams + endpoint)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        urlRequest.allHTTPHeaderFields = ["":""] //teamsID?
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error  = error {
                print(error)
                // should add handling here but just to make process continue
            }
            else if let data = data, let responseCode = response as? HTTPURLResponse{
                do {
                    // should add handling here but just to make process continue
                    let user = try self.decoder.decode(Team.self, from: data)
                    completion(user)
                }
                catch let parseJSONError{
                    print("parse failed: \(parseJSONError)")
                    // should add handling here but just to make process continue
                }
            }
        
        }.resume()
        
        do {
            // read local json for mock data only
            guard let url = Bundle.main.url(forResource: "User_" + teamsID, withExtension: ".json")
            else {
                print("Invalid url.")
                return
            }
            let data = try? Data(contentsOf: url)
            let user = try decoder.decode(Team.self, from: data!)
            completion(user)
           
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getURL(teamsID: String, role : String, completion : @escaping (URLResponse) -> ()){
        //make extentions or helpers for below if have time
        let endpoint = "teams/" + teamsID + "/invites"
        var urlRequest = URLRequest(url: URL(string: urlTeams + endpoint)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        urlRequest.allHTTPHeaderFields = [
            "role": role
        ]
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error  = error {
                print(error)
                // should add handling here but just to make process continue
            }
            else if let data = data, let responseCode = response as? HTTPURLResponse{
                do {
                    // should add handling here but just to make process continue
                    let urlObject = try self.decoder.decode(URLResponse.self, from: data)
                    completion(urlObject)
                }
                catch let parseJSONError{
                    print("parse failed: \(parseJSONError)")
                    // should add handling here but just to make process continue
                }
            }
        }.resume()
        
        let urlObject = URLResponse(url: "https://sample.com/ti/quejdowjDJKl/" + role)
        completion(urlObject)
    }
}





