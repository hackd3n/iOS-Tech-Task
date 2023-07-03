# Solution:

My solution involves:
- Creating a custom UInavigation with the LoginViewController as the root 
to be directed to with errors including session expiry

- I used to the login method from data provider API and assigned the 
sucess to the navigation  to the accounts view

- I utilised the UITableView protocols and create a custom cell view for 
the UI of the accounts held and in turn used this for individual product 
selection

- Passing the index row as the position in the accounts held array to 
handle inidividual products in the product view

- I utilised the addmoney method to make an api reqest to add a set amount 
to the moneybox total for the selected product and the UI responds by 
returning to the parent view. 

 # Moneybox iOS Technical Challenge

## The Brief

To create a 'light' version of the Moneybox app that will allow existing users to login and check their account balance, as well as viewing their Moneybox savings. 
- To fork this repository to your private repository and implement the solution.
 
### The app should have
- A login screen to allow existing users to sign in
- A screen to show the accounts the user holds, e.g. ISA, GIA
- A screen to show some details of the account, including a simple button to add money to its moneybox.
- The button will add a fixed amount of £10. It should use the `POST /oneoffpayments` endpoint provided, and the account's Moneybox amount would be updated.

A prototype wireframe of all 3 screens is provided as a guideline. You are free to provide additional information if you wish.
![](wireframe.png)

### What we are looking for
 - Demonstration of coding style, conventions and patterns.
 - Use of autolayout (preferably UIKit).
 - Implementation of unit tests.
 - Any accessibility feature would be a bonus.
 - The application must run on iOS 13 or later.
 - The application must compile and run on Xcode and be debugged in Xcode's iOS simulator.
 - Any 3rd party library should be integrated using Swift Package Manager.
 - No persistence of the user is required.
 - Showcase what you can do.

### API Usage
The Networking methods and Models for requests and responses are ready-made in the Networking module of the project.

#### Base URL & Test User
The base URL for the moneybox sandbox environment is `https://api-test02.moneyboxapp.com/`. </br>
You can log in using the following user:

|  Username          | Password         |
| ------------- | ------------- |
| test+ios2@moneyboxapp.com  | P455word12  |

#### Authentication
You should obtain a bearer token from the Login response, and attach it as an Authorization header for the endpoints. Helper methods in the API/Base folder should be used for that.
(Note: The BearerToken has a sliding expiration of 5 mins).

| Key  |  Value  |
| ------------- | ------------- |
| Authorization |  Bearer TsMWRkbrcu3NGrpf84gi2+pg0iOMVymyKklmkY0oI84= |

#### API Call Hint

```
let dataProvider = DataProvider()
dataProvider.login(request: request, completion: completion)
```
request: Initialize your request model </br>
Completion: Handle your API success and failure cases

## Unit Tests
The MoneyBoxTests folder includes stubbed data to easily mock the responses needed for unit testing

#### Usage Hint
You can create a DataProviderMock class via inject DataProviderLogic protocol </br>
You can mock response in Login.json file like this:
```
StubData.read(file: "Login", callback: completion)
```

### How to Submit your solution:
 - To share your Github repository with the user valerio-bettini.
 - (Optional) Provide a readme in markdown which outlines your solution.

## Good luck!
