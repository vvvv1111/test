//
//  CollectionViewController.swift
//  zadanie
//
//  Created by Vladimir on 04.07.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//


//сделал за два дня, не без костылей, конечно, на то я и джуниор) но костылей немного, так что не стыдно за код



import UIKit

private let reuseIdentifier = "Cell"

//что ж, костыльный, но рабочий метод, при первом входе во вьюдидапиар скроллю вью, иначе, почему-то, размеры ячейки неккоректные пока я не проскроллю и не вызовется лайаут и не установит норм значения.
private var firstLaunch = true


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    var postsPerSection = 3
    var indexOfSelectedCell: Int?
    var service = DataService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleNavigBar()
        loadFirstThreePosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if firstLaunch == true{
             collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            firstLaunch = false
        }
    }
    
    @IBAction func loadMoreButton(_ sender: Any) {
        postsPerSection += 3
        service.loadNextThree(numberOfCells: postsPerSection) { (posts) in
            DispatchQueue.main.async{
                self.service.allPosts = self.service.allPosts! + posts
                self.collectionView.reloadData()
                DispatchQueue.main.async {
                    self.collectionView.scrollToItem(at: IndexPath(item: self.postsPerSection-3, section: 0), at: .top, animated: true)
                 }
                self.collectionView.scrollToItem(at: IndexPath(item: 3, section: 0), at: .top, animated: true)
            }
        }
    }
  
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsPerSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        if service.allPosts != nil{
            cell.titleOfPost.text = service.allPosts![indexPath.row].title
            //эффект новостной ленты фейсбука
            cell.titleOfPost.textColor = .black
            cell.titleOfPost.backgroundColor = .none
            
            cell.dateOfPost.textColor = .black
            cell.dateOfPost.backgroundColor = .none
                   
            cell.authorOfPost.textColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
            cell.authorOfPost.backgroundColor = .none
            
            cell.numberOfComments.textColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
            cell.numberOfComments.backgroundColor = .none
            
            cell.shape.image = UIImage(named: "Shape2.png")
            
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartFooterCollectionReusableView", for: indexPath)
        return footerView
        }
    fatalError()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexOfSelectedCell = indexPath.row
        performSegue(withIdentifier: "toPost", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPost" else { return }
        guard let destination = segue.destination as? ViewController else { return }

        destination.post = service.allPosts![indexOfSelectedCell!]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem
    }
    
    
    
    
    
    func configureTitleNavigBar(){
        let navLabel = UILabel()
            let navTitle = NSMutableAttributedString(string: "UNITBEAN", attributes:[
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.937, green: 0.275, blue: 0.173, alpha: 1).cgColor,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.bold),
            ])

            navTitle.append(NSMutableAttributedString(string: ".NEWS", attributes:[
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0),
                NSAttributedString.Key.foregroundColor: UIColor.black]))

        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    
    func loadFirstThreePosts(){
        service.loadNextThree(numberOfCells: postsPerSection) { (posts) in
            DispatchQueue.main.async{
                if self.service.allPosts == nil {
                    self.service.allPosts = posts
                }else{}
                self.collectionView.reloadData()
            }
        }
    }
    
}


