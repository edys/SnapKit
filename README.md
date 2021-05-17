Hi everyone, in this exmaple you will see the use of SnapKit, Redux and Combine :)

The projact is spilt into 3 part following a 3 layered architectural approch.
 
 - Presention Layer -> UI components using UIKit and SnapKit
 - Business Layer -> redux, actions and thunk for loading image
 - Data Layer -> using combine and AF networking 

Mostly everything is seperated with Protocol and using FieryCrucible to glue the application together. (please see Factory class in the different layers)

The App project is what should be built to launch the app and the SPD project is for common Switf Package.

Unit tests are not done as of yet :(
