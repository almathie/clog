# Clog

## Introduction

Clog (Cloud + Log) is a cloud logging platform. Clog is implemented as a Rack application built using the sinatra framework and uses mongodb to store the log messages.

Client send their log messages via HTTP requests on the REST API provided by this package.

Each log message consists of a text string and zero, one, or more tags. Each tag is a [key, value] pair, where both the key and the value is a text string.

Each log message is sent by a user, and is linked to a specific project. Tags can be set at the project level in wich case they act as "default values" for all log messages coming in for that project.

## Installation and usage

### 1. Configure your database
Edit config/config.yml

### 2. Install the gems
    gem install bundle
    bundle install

### 3. Create a user
    rack user:create["username"]
This will create a user named "username" with a random access token.
    
### 4. Start the app
Any web server that support Rack will do. 

### 5. Create a project
    curl -H "Content-Type: application/json" -H "Authorization: OAuth TOKEN" \
    -d '{"name":"project-name", "tags":{"project-tag-1":"tag-1-value", "project-tag-2": "tag-value-2"}}' \
    "http://host:port/projects"

  - Don't forget to replace `TOKEN` in the Authorization header by the token that was generated during step 3.

### 6. Log a message
    curl -H "Content-Type: application/json" -H "Authorization: OAuth TOKEN" \
    -d '{"message":"log message", "tags":{"message-tag-1":"message-tag-1-value", "project-tag-2": "overriden-value"}}' \
    "http://host:port/projects/PROJECT_NAME/logs"

  - Don't forget to replace `TOKEN` in the Authorization header by the token that was generated during step 3.
  - Don't forget to replace `PROJECT_NAME` in the URL by the name of the project that was generated during step 5.
