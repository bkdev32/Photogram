//
//  FeedViewController.swift
//  Photogram
//
//  Created by Burhan Kaynak on 26/07/2021.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UITableViewController {
    var users = [User]()
    let db = Firestore.firestore()
    var photos = [Photo]()
    let session = Session()
    
    let notClicked = UIImage(systemName: "hand.thumbsup")
    let clicked = UIImage(systemName: "hand.thumbsup.fill")
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController!.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController!.navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: P.General.cell, bundle: nil), forCellReuseIdentifier: P.General.cell)
        fetchPosts()
    }
}

extension FeedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = photos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: P.General.cell, for: indexPath) as! FeedCell
        cell.userImage.sd_setImage(with: URL(string: photo.imageUrl))
        cell.usernameField.text = photo.postedBy
        cell.postID.text = photo.id
        cell.postTitle.text = photo.postTitle
        cell.likeCount.text = String(photo.likes)
        
        let currentUser = session.user?.uid
        db.collection("Posts").document(cell.postID.text!).getDocument { query, err in
            if let likeArray = query?.get(P.Fire.likers) as? [String] {
                for user in likeArray {
                    if user == currentUser {
                        cell.likeBttn.setImage(self.clicked, for: .normal)
                        cell.likeBttn.isEnabled = false
                    } else {
                        cell.likeBttn.setImage(self.notClicked, for: .normal)
                        cell.likeBttn.isEnabled = true
                    }
                }
            }
        }
        return cell
    }
    
    func fetchPosts() {
        db.collection(P.Fire.collection)
            .order(by: P.Fire.date, descending: true)
            .addSnapshotListener { [self] query, err in
                if err != nil {
                    print(err!.localizedDescription)
                } else {
                    if query?.isEmpty != true && query != nil {
                        photos.removeAll(keepingCapacity: false)
                        
                        for doc in query!.documents {
                            let id = doc.documentID
                            
                            if let image = doc.get(P.Fire.imageUrl) as? String,
                               let title = doc.get(P.Fire.postTitle) as? String,
                               let postedBy = doc.get(P.Fire.postedBy) as? String,
                               let date = doc.get(P.Fire.date) as? NSObject,
                               let likes = doc.get(P.Fire.likes) as? Int
                            {
                                let photo = Photo(
                                    id: id, imageUrl: image, postedBy: postedBy,
                                    postTitle: title, date: date, likes: likes)
                                photos.append(photo)
                            }
                        }
                        tableView.reloadData()
                    }
                }
            }
    }
}
