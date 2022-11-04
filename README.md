# Word Suggestion

This project was developed in Dart using Flutter SDK.</br></br>

Project purpose: It is to help users who want to improve their English by offering daily word suggestions.

## Materials and Methods

- User Log In - Log Out:</br></br>
"Firebase Authentication" is used in user registration and login functions.</br>
In order to log in, the membership must be approved by the e-mail sent to the user. After login and registration "verify_screen" checks the confirmation status.</br>
User actions are controlled by a stream with the "main" method.</br>
A password reset e-mail is sent to the user's e-mail address with the "Forgot password" link.</br></br>

- User Register:</br></br>
User registration can be done with the "Register" button on the "Login" screen.</br>
There are "Required" fields in the form on this screen. This requirement is checked with the "Sign Up" button and a warning is given.</br>
After registration, a field is created in the database for user information.</br></br>

- Profile Editing:</br></br>
If the user is logged in, there is a page where he can edit his own information. Here the user will be able to edit the information that can be changed.</br></br>

Word Suggestion:</br></br>
On the word suggestion page, 10 words are suggested to the user. These words and their meanings are taken from "dictionaryapi.dev" in json data type.</br>
With each word, the user will be presented with "I learned" and "Remind me later" options.</br>
If the user says "I learned", the word ID will be kept in the 'Users' table and the same word will not be suggested again.</br>

- Learned Words:</br></br>
The user can mark the learned words as "Unlearned" on the Word List (word_screen) page.</br></br>

## Notes
-- 2 sidebars are used in this project. "classic" and "hidden" under the drawer folder. "classic", the classic drawer included with flutter. "hidden" is taken from pub.dev.</br>
-- The word suggestion function starts from the "suggestion_main_screen.dart" file under the "screens_home" folder and continues with the files under the "suggestion" folder.</br>
-- The classes and files that make up the other functions are specified in the folder names under the "lib" folder.</br></br>

## How To Setup</br>
- Follow the steps in the video... </br>
[![Watch the video](https://img.youtube.com/vi/dhS4YgOyCzk/hqdefault.jpg)](https://youtu.be/dhS4YgOyCzk)<br/>