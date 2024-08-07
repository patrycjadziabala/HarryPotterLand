//
//  Constants.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation

struct Constants {
    
    struct Titles {
        static let titleHarryPotterLand = "Harry Potter Land"
        static let titleMoviesCollection = "Movies Collection"
        static let titleCharacters = "Characters"
        static let titleMovies = "Movies"
        static let enter = "Enter"
        static let pressAndHold = "Press and hold 🎵"
        static let signIn = "Sign in"
        static let signOut = " Sign out"
        static let welcomeToHPWorld = "Welcome to Harry Potter world"
        static let pleaseSignIn = "Please sign in to enter"
        static let pleaseEnterYourLogin = "Plase enter your login"
        static let pleaseEnterYourPassword = "Plase enter your password"
        static let yourLogin = "Your login"
        static let yourPassword = "Your password"
        static let confirmPassword = "Confirm password"
        static let pleaseEnterYourAge = "Please enter your age"
        static let pleaseSelectYourGender = "Please select your gender"
        static let male = "Male"
        static let female = "Female"
        static let nonbinary = "Non-Binary"
        static let finish = "Finish"
        static let next = "Next"
        static let alertLogin = "Your login must be at least 3 characters long 😬"
        static let alertPasswordLength = "Your password must be at least 3 characters long 😬"
        static let alertPasswordSpecialCharacters = "Your password must contain at least 1 special character (eg. !, *, &) 😬"
        static let alertPasswordsDontMatch = "Passwords don't match! Please re-enter"
        static let alertGender = "Please select your gender 😬"
        static let selectGender = "Select a gender"
        static let student = "Student"
        static let staff = "Staff"
        static let home = "Home"
        static let fav = "Fav"
        static let search = "Search"
        static let house = "House:"
        static let species = "Species:"
        static let alive = "Alive:"
        static let dateOfBirth = "DOB:"
        static let actor = "Actor:"
        static let eyeColor = "Eye color:"
        static let hairColor = "Hair color:"
        static let ancestry = "Ancestry:"
        static let patronus = "Patronus:"
        static let wizard = "Wizard:"
        static let releaseDate = "Release date:"
        static let originCountry = "Origin Country:"
        static let budget = "Budget:"
        static let rating = "Rating:"
        static let scrollUp = "Scroll up for more info ⇧"
        static let na = "N/A"
        static let explore = "Explore 👇🏻🌎"
        static let fandom = "Fandom"
        static let notAvailable = "Not available"
        static let unknown = "Unknown"
        static let searchForYourFavouriteCharactersOrMovies = "Search for your favourite characters or movies:"
        static let searchByNameOrTitle = "Search by name or title..."
        static let go = "Go"
    }
    
    struct Images {
        static let hogwartsCastleImageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/b/b2/Hogwarts_-_Wizarding_World_of_Harry_Potter_-_Hollywood.jpg")
        static let hogwartsCastleCartoon = "hogwartsCastleCartoon"
        static let homeIcon = "house.fill"
        static let starFillIcon = "star.fill"
        static let searchIcon = "magnifyingglass"
        static let hogwartsLogo = "HogwartsLogo"
        static let xMarkCircleIcon = "xmark.circle.fill"
        static let xMark = "xmark"
        static let arrowRightIcon = "arrowshape.right.circle.fill"
        static let eyeCrossedIcon = "eye.slash.fill"
        static let eyeIcon = "eye.fill"
    }
    
    struct Colors {
        //Griffindor
        static let griffindorDarkRed = "DarkRed"
        static let griffindorRed = "Red"
        static let griffindorGold = "Gold"
        static let griffindorYellow = "GriffindorYellow"
        
        //Hufflepuff
        static let hufflepuffCanary = "Canary"
        static let hufflepuffLightCanary = "LightCanary"
        static let hufflepuffDarkBrown = "DarkBrown"
        static let hufflepuffLightBrown = "LightBrown"
        
        //Ravenclaw
        static let ravenclawBlue = "Blue"
        static let ravenclawDarkBlue = "DarkBlue"
        static let ravenclawGrey = "Grey"
        static let ravenclawGold = "RavenclawGold"
        
        //Slytherin
        static let slytherinDarkGreen = "DarkGreen"
        static let slytherinDarkSilver = "DarkSilver"
        static let slytherinLightSilver = "LightSilver"
        static let slytherinGreen = "Green"
    }
    
    struct Fonts {
        static let fontWelcomeScreen = "HarryP"
        static let fontDumbledor = "Dumbledor1"
        static let fontText = "Dumbledor1"
        static let fontSnitch = "jlrsnitch"
    }
    
    struct apiKey {
        static let theMovieDB = "api_key=29d1eac12ae7da1b5df0ba13aca09837"
    }
    
    struct HPid {
        static let idHP1 = "671"
        static let idHP2 = "672"
        static let idHP3 = "673"
        static let idHP4 = "674"
        static let idHP5 = "675"
        static let idHP6 = "767"
        static let idHP7 = "12444"
        static let idHP8 = "12445"
        static let allIds: [String] = [HPid.idHP1, HPid.idHP2, HPid.idHP3, HPid.idHP4, HPid.idHP5, HPid.idHP6, HPid.idHP7, HPid.idHP8]
    }
}
