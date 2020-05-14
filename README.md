# BengalEvents

## A replacement webapp for the Bengal STEM Day and other events.
   
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

    
 

