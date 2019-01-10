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
        
MyPhotoGuide uses below Cocoapods.
1. Alamofire


