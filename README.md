# Coding Challenge

*If you have any questions, please contact us.*

## Task

Please write an iOS app in Swift, that contains two screens as described below:

* Login screen
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

* Success screen
	* label "hello."
	* navigation bar with back button

* Networking
	* https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/test/authenticate
	* POST `{ "email": "...", "password": "..." }` (fill in values)
	* expect (200, 401 or 500 will be randomly returned by the api, so you will see all the cases in the app)
		* 200: `{ "token": "uuidv4", "message": "Sample greetings message" }`
		* 401: `{ "message": "Sample authentication error message" }`
		* 4xx/5xx (if something really goes wrong)

* Architecture
	* follow the architecture provided in the template app (MVP)

* Notes
	* use of libraries/CocoaPods/Carthage is permitted (not necessary). Make sure to include all libraries in your project, so a simple build/run of the app will work without any other setup.

* Version control
  * create a branch `test/firstname-lastname`
		* making meaningful commits during implementation is a plus
		* review your branch before sending it

**Please send the result zipped (including .git folder) via email when you are done.**

### Good luck!
