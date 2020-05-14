# expertlead Coding Challenge

A solution to the [expertlead](https://www.expertlead.com) coding challenge. 

## Overview of the repository

This project directory structure is organised in the same way as the code: both follow the layered structure of the [Model View Presenter architecture](https://github.com/FortechRomania/ios-mvp-clean-architecture). The presentation layer is on top, 
followed by the application logic layer, and lastly the (data) gateways are at the bottom. Unit tests are organised in the same way.

Both the presentation and application logic layers are *fairly* well-covered by tests. As the gateway is only responsible 
for fetching external data (there is no persistence in the demo app) and it uses a [third party networking library](https://github.com/objcio/tiny-networking)  it is not well tested: I didn't want to spend too much time testing someone else's code. That being said, where my code and the third party code meet should be well tested and that is probably the next thing I would do to get this demo app production ready. (Although IMO it would be better write my own networking code, test *that*, and remove the only thrid-party dependancy.)

I've left in some `TODO`s where I thought it was appropriate. Hopefully these give some insight into my thought process during development.

There is an atomic commit history so the step-by-step detail of how I built the project (from the presentation layer down) can be found in the git log.

I also made some simplifying assumptions in places to avoid spending too much time on details: 
* the UI doesn't rotate or handle iPad screens correctly; 
* text used in the UI isn't localised; and 
* design primitives such as colours and line widths are hard-coded in views. 

I wouldn't consider these things "correct" in a production-ready iOS app, but I think that they are acceptable a coding challenge given the need to save time while demostrating other hard skills like unit testing and version control.

The project has been tested on iOS 12 and 13 and *should* run straight off the bat.

## The challenge

The challange was to write an iOS app in Swift, that contains two screens as described below:

### Login screen
* text field for email (validate for existence of "@", change border colors to black/red/blue)
* text field for password (validate for non-empty, change border colors to black/red/blue)
* button for login
	* disable on validation failure
	* title
		* "Login" (default)
		* "Cancel" (while request is running)
		* "Try again" (after request has failed)
* activity indicator (when request is running)
* error label
	* empty (default)
	* text (localizedMessage from backend, when request has failed)

### Success screen
* label "hello."
* navigation bar with back button

### Additional information
* Networking
  * https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/test/authenticate
  * POST `{ "email": "...", "password": "..." }` (fill in values)
  * expect (200, 401 or 500 will be randomly returned by the api, so you will see all the cases in the app)
  	* 200: `{ "token": "uuidv4", "message": "Sample greetings message" }`
  	* 401: `{ "message": "Sample authentication error message" }`
  	* 4xx/5xx (if something really goes wrong)
* Architecture
  * follow the architecture provided in the template app (MVP)
* Version control
  * create a branch `test/firstname-lastname`
  * making meaningful commits during implementation is a plus
  * review your branch before sending it
* Notes
	* use of libraries/CocoaPods/Carthage is permitted (not necessary). Make sure to include all libraries in your project, so a simple build/run of the app will work without any other setup.
