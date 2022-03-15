# 📸 Photogram

Simple photo sharing app using <a href="https://firebase.google.com" target="_blank">Firebase</a> Authentication and Storage with the ability to edit images before upload using Core Image Filters (up to 7)

I am currently working on extending the available features further by adding the ability to unlike & comment and additional image editing capabilities. 

I have also identified a bug with the like feature that I have only noticed recently which I am working to fix and publish changes.

![ezgif com-gif-maker](https://user-images.githubusercontent.com/11230240/139673776-596ee69c-b5f3-4922-84f5-8132aa30c591.gif)

## Project Setup

To be able to run this project, you will need to have a [Firebase](https://firebase.google.com) account.

Set up a new project on Firebase Console and follow the instructions to add config file and Firebase SDK.

Clone the repository and run:

``` pod init ```

Add the following to your project Podfile

``` 
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
  pod 'SDWebImage', '~> 5.0'
```

Then run:

``` pod install ```

Once the setup is completed, you will need to create a Firestore database and set-up the user Authentication. You can access the Firebase docs at [firebase.google.com](https://firebase.google.com/docs/build) 

=====================



