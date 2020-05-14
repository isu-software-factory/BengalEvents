# BengalEvents

## A replacement webapp for the Bengal STEM Day and other events.

### Ruby Version
- The ruby version installed currently is 2.5.5.

### Guide for Installation and initial configuration

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
- In terminal, run 'rails server'
- Go to "localhost:3000" in browser to see homepage.

## Database Intilization
   This app use mysql 2 as the backend database. 
   - Before configuring the database, please install mysql server.
        - sudo wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
        - sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
- You’ll need to start the MySQL service by entering:
        - sudo systemctl start mysqld
- To check the status of MySQL use the command:
        - sudo systemctl status mysqld
   
 - To configure the database:
   - Install mysql 2 gem. This can be done my adding "gem mysql2" in the GemFile.
   - To allow rails to use database, go to config/database.yml and setup the database. Use the following in the database.yml file.   
       - adapter: mysql2
       - encoding: utf8
       - database: bengalevents
       - username: someuser
       - password: somepassword
   - Run rails db:create db:migrate --trace from the command line to make sure it works.
   
## Testing
- When testing with Capybara and Selenium make sure that you have chrome installed before your run the tests. It will throw an error otherwise. Also make sure that the chrome version is 79 or it will not work either. 
- Only works on **Linux** and **Windows**
- To run the features tests with Selenium, run using `rspec spec/features` to run all features tests. 
- To run the model tests, run using `rspec spec/models` to run all model tests.


## Deployment instructions

For deploying please see the attached document named "Deployment.docx" in docs folder.

## Docker Instructions

- Install Docker 
    - In the terminal, run 'sudo apt-get update'
    - 'sudo apt-get update'
    - 'sudo apt-get install docker-ce docker-ce-cli container.io'
- Verify Docker Engine is installed correctly, run
    - 'sudo docker run hello-world'
- Install Docker-Compose 
    - In the terminal, run 'sudo apt-get install curl -y'
    - 'sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose'
- Verify Docker-Compose Version/Installation 
    - 'docker-compose -v'
- Create Docker Image
    - In the 'BengalApplication' folder, pull latest update 'git pull origin dev'
    - sudo docker-compose run --rm web rake db:migrate
- Run Docker Image
    - sudo docker-compose up
    - check localhost:3000, it should be running in the Admin Setup page.

    
 

