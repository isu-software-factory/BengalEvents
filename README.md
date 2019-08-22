# BengalEvents

## A replacement webapp for the Bengal STEM Day and other events.

### Guide for Installation and initial operation

- Download rails packages software at "http://railsinstaller.org/en" based on your operating system.
    - This bundled download includes Ruby, Rails, Git, Bundler, Sqlite, and more.
    - Follow link, then click on the button labeled Windows to start download.
    - Follow prompts from installation wizard and go through the setup files.
    
- Confirm download versions
    - Run commands in terminal `ruby -v`, `gem -v`, and `rails -v`. The application uses 2.5.5 for ruby, 5.2.3 for rails, 2.7.6.2 for gem. 
    - If the `ruby -v` does not match with the application go to this website to download the version.                 https://rubyinstaller.org/downloads/
    - In the ruby installer, the recommend version is Ruby+Devkit 2.5.5-1(x64) because it provides the biggest number of compatible gems       and installs MSYS2-Devkit alongside Ruby, so that gems with C-extensions can be compiled immediately.
    
- Clone/download code from github "https://github.com/isu-software-factory/BengalEvents.git"
- Open up the application on any IDE.
- Using terminal, run `bundle install`
    - If error "You Must use Bundler 2 or greater" run `gem install bundler`, then run `bundle install` again
- Run `rails db:migrate` in the terminal to migrate the database.
   -  The database used for development is sqlite3. Make sure sqlite3 gets installed along with the packages. 
   -  To check the version of any gem installed, type bundle show [gemname] in the terminal. In the sqlite3 case,`bundle show sqlite3`
- In terminal, run "rails server"
- Go to "localhost:3000" in browser to see homepage.
