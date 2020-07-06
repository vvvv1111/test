//
//  Data.swift
//  zadanie
//
//  Created by Vladimir on 04.07.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import Foundation

struct Post: Decodable {
    var title: String?
    var body: String?
}


class DataService{
    var allPosts: [Post]?
    
    func loadNextThree(numberOfCells: Int, completion: @escaping ([Post]) -> Void){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard error ==  nil else {return}
            do{
                //проверка чтобы не выйти за массив
                let lengthOfArray = try JSONDecoder().decode([Post].self, from: data).count
                if numberOfCells-3 >= lengthOfArray{return}
                
                var posts = try [JSONDecoder().decode([Post].self, from: data)[numberOfCells-3]]
                if numberOfCells-2 >= lengthOfArray{return}
                try posts.append(JSONDecoder().decode([Post].self, from: data)[numberOfCells-2])
                if numberOfCells-1 >= lengthOfArray{return}
                try posts.append(JSONDecoder().decode([Post].self, from: data)[numberOfCells-1])
                completion(posts)
            }catch{
                print(error)
            }
        }
        .resume()
    }
    
    
}
