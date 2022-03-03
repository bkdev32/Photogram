//
//  FeedCell.swift
//  Photogram
//
//  Created by Burhan Kaynak on 26/07/2021.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var usernameField: UILabel!
    @IBOutlet weak var postID: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var likeBttn: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    
    let db = Firestore.firestore()
    let session = Session()
    var numberOfLikes = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        let docRef = db.collection(P.Fire.collection).document(postID.text!)
        let currentUser = session.user?.uid
        
        docRef.addSnapshotListener { [self] snapshot, err in
            guard let document = snapshot else {
                print("Error fetching document: \(err!)")
                return
            }
            
            guard let data = document.get(P.Fire.likers) as? [String] else { return }
            if !data.contains(currentUser!) {
                if let likes = Int(likeCount.text!) {
                    let likeStore = [P.Fire.likes: likes + 1] as [String: Int]
                    docRef.updateData([
                        P.Fire.likes: likes + 1,
                        P.Fire.likers: FieldValue.arrayUnion([currentUser as Any])
                    ] as [String: Any])
                    numberOfLikes = likeStore[P.Fire.likes] ?? 1
                    likeCount.text = String(numberOfLikes)
                }
            }
        }
    }
}
