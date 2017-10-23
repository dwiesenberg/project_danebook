# Danebook Goes Live -- With Authentication

DAVID WIESENBERG

Note: Many coding ideas taken from James Harris' Danebook Goes Live (Final Edition)  

# ################################################

James Harris' notes on his f9inal project were:

**[View on Heroku](http://jamesharris-danebook.herokuapp.com/)**

I made a social network prototype to help me learn Ruby on Rails. Features:

- [x] Sign up as a new user and it will create a profile page for you
- [x] You can save information on the profile page and it will be visible to other users
- [x] Search for other users by name, or click "Find Friends" for a list of all users
- [x] Write posts for your timeline
- [x] Comment on other people's posts
- [x] "Like" other people's posts and comments
- [x] Upload photos (hosted on AWS)

Known bugs:

- [ ] Images hosted on AWS are displayed via an expiring URL, which is generated anew for each pageload. This mitigates against hotlinking, but also causes images to be redownloaded, at full size, with each pageload.
- [ ] User search only works by first name
