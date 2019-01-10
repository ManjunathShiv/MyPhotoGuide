# MyPhotoGuide


MyPhotoGuide is an application where you will be able to see all your latest instagram uploads. 
1. Authentication of user using instagram web login. The Instagram authentication happens through the WKWebview.
2. Once the Authentication happens, MyPhotoGuide fetches a code in the redirect URL specified in the Instagram Sandbox.
3. The Code will be used for obtaining the Access Token for the user who authenticated.
4. Once the Access Token is received.
    - The User Profile Information is fetched using the Below API.
        .   https://api.instagram.com/v1/users/self/?access_token=ACCESS-TOKEN
    -  The User Recent Uploads using the Instagram API.
        .   https://api.instagram.com/v1/users/self/media/recent/?access_token=ACCESS-TOKEN
        
# Prerequisites

1. Xcode Version 10
2. Swift 4.2
3. SourceTree
4. Minumim SDK Version 11.0
5. Cocoapods - Alamofire

# Architecture Used

Main Parts of VIPER
The main parts of VIPER are:

1. View: displays what it is told to by the Presenter and relays user input back to the Presenter.
2. Interactor: contains the business logic as specified by a use case.
3. Presenter: contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor).
4. Entity: contains basic model objects used by the Interactor.
5. Routing: contains navigation logic for describing which screens are shown in which order.

# Improvements

o	A carousel for viewing all the images which are uploaded together. Currently only one image out of the group is displayed.

o	A Pan functionality while zooming on the image.

o	Error Handling in all the places if a API fails to load.

o	A proper redirect URL to fall back on.

o	Social Login support, Currently the social login (Facebook) is not supported.

# Author
Manjunath Shivakumara - (https://github.com/ManjunathShiv)

