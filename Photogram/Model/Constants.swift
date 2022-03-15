//
//  Constants.swift
//  Photogram
//
//  Created by Burhan Kaynak on 26/07/2021.
//

import UIKit

enum P {
    enum Segue {
        public static let signInToFeed = "signInToFeed"
        public static let signUpToFeed = "signUpToFeed"
        public static let signInToForgotPass = "signInToForPassVC"
        public static let changeName = "toChangeUsername"
        public static let changePassword = "toChangePassword"
        public static let changePasswordToLogIn = "updatePasswordToLogInVC"
    }
    enum General {
        public static let cell = "FeedCell"
        public static let chooseImage = UIImage(named: "select-image")
        public static let likeClicked = UIImage(systemName: "hand.thumbsup.fill")
    }
    enum Fire {
        public static let collection = "Posts"
        public static let imageUrl = "imageUrl"
        public static let postedBy = "postedBy"
        public static let postTitle = "postTitle"
        public static let date = "date"
        public static let likes = "likes"
        public static let likers = "likers"
    }
}
