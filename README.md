# [Gem It](http://gemit.us/)

## Description

[Gem It](http://gemit.us/) is a web app that users can enter a url and make mini scraping gem with its content.

## Background

This app was made with Ruby Developers in mind. Having had the frustration of wanting snippets of information from a website and not wanting to make a scraper to simply retrieve the information we decided we needed a better way.

## Features
- Grab text, links, or and media paths from a website
- Said information is pacakaged into an easy to use gem.
- Gem It can now retieve any computed CSS on the website of your choice!

## Usage
<b>How to use [Gem It](http://gemit.us/)</b>
  1. Sign in with Github so we can set up a repo.
  2. Submit the URL you want us to scrape from.<br>
  3. Click however many targets on that page you want.<br>
  4. Fill out some details.<br>

<b>How to use one of our gems</b><br>
  Run these commands in your terminal to will install your gem.<br>
<code> git clone git@github.com:YourUserName/YourGem.git. </code><br>
<code> cd YourGem </code><br>
<code> gem install YourGem </code>
  
  <b>Command Line</b><br>
  Call it with <code>YourGem</code>
  
  <b>Rails</b><br>
  <code>require 'YourGem', git: 'git@github.com:YourUserName/YourGem.git.'</code><br>
  <code>a_variable = YourGem::Magick.new.call</code><br>
  <code>a_variable.your_method</code>

## Development/Contribution

Have a problem with the website? Want a new feature? Leave an issue or Fork Us!

## Future

Currently, we're working on allowing users to grab information from multiple websites with one gem.
If you have any suggestion please let us know!

## Author

Our gems are cut with love by [Tristan](https://github.com/TSiege), [George](https://github.com/georgemayer), and [Patrick](https://github.com/patrickwhitrock).

## License

Gem It is MIT Licensed. Use any or all of it as you see fit.
