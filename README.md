# README

A basic facebook clone built as a learning experience with [The Odin Project](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project).
Visit a live version of the site on heroku: [Spacebook](https://spacebook-q.herokuapp.com).

## Features

- Built using Ruby on Rails to showcase and flex my knowledge of the framework.
- Users can like, comment, create, update and delete text posts, as well as friend and unfriend other users.
- Set up after action callbacks to automatically supply new users with friend requests so they have posts to see.
- Extensive implementation of Turbo drive and streaming to have a mostly single page application like functionality with snappy loading.
- Example: The Like and Unlike buttons changing without a full page refresh, Creating a new post or comment adding to the page without having to visit a page with the form and then come back to the index.
- CSS styled after facebook's light theme with minimal tweaks.
- Sass used with CSS to make use of nesting for organization.
- Use of Stimulus controllers to add light and flexible javascript touches.
- Omniauth integration for signing up and in with actual Facebook.
- A number of tests using Minitest and Capybara to make sure some of the core functionality did not break when adding or changing things.
- Turbo-stream and frames to create a infinitely loading feed. (Note: for some reason this functionality seems to be broken on the mobile version of firefox, thus this may not be functioning with other browsers that I have not tested. It does however work with chrome mobile, and both chrome and firefox desktop browsers. Sorry for any inconvenience, but I'm not sure I have the resources to track this down for now.)



## Reflection

- Biggest project I've done so far with web development. The MVC framework and the 'Rails Way' of doing things really helped keep the project organized. I think trying out SCSS and using it to keep the css files organized really helped as well. It was super easy to find what I needed to whenever I needed to fix some bug or implement something new.
- Was my first time using tests for a Rails project. I need to go through and test more of the application, but already see the benefit. Using tests and guard it was easy to see when I had managed to break something in some unforeseen way.
- Was also my first time using media queries in an actual project to adjust based on screen size. I didn't use them too much, but made sure the pages were responsive on both mobile and desktop.
- Developing the friends was a bit of a pain. At first I conceived as both the friend requests and friendships on the same model with a sort of status of whether or not the friendship was pending. I thought this would save me some duplication needed if they were separate, but it ended up being worse in the long run due to how to query the different things I needed on different parts of the application. Instead, I made it where when a friendship request is accepted, two entries are made on the friendship model. This way, it did not matter who sent the request, both sides of the friendship would be able to see the other by just doing a .friends query on the user in question. While at first I thought this would be inefficient, setting it up to create and delete two entries when making or destroying a friendship was actually quite easy with the callbacks.
- I actually am quite proud of some of the functionality I got going with the hover on usernames. I set this up so each of these hover icons are lazy loaded so the current user's friendship with any given user doesn't need to be queried until you hover over their name.
- I realize with the turbo streams changing the content on the page as you like and comment, the flash notices aren't the most necessary, but I liked implementing them and kept them there just to show off both skills.
- There's still a lot of functionality I can add to the page and some of it I may still get to, but I think this is a good amount for a big project to show what I can do.

