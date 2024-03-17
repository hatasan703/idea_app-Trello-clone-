# Board View App

## Description
A web app for managing ideas, featuring a Trello-like board view as its main functionality.

## Technology Stack
- Framework: Rails 5.2.3
- Backend: Ruby 2.5.1
- Frontend: HTML, CSS, JavaScript, Vue.js
- Database: MySQL
- Deployment: -

## Features
- Board View: Manage and organize ideas in a visual board format similar to Trello.
- Idea Management: Create, edit, and delete ideas within boards.
- Plan Association: Associate detailed plans with ideas.
- User Authentication: Sign-up and login functionality with devise.
- Real-Time Interaction: Utilize Action Cable for real-time updates and communications.
- Idea Collaboration: Users can comment on and like ideas for collaborative discussion.
- Personal Profiles: Manage user profiles with custom information.
- Search Functionality: Search for users and ideas based on various criteria.

## Setup

MySQL Installation
```
```

Ruby Installation (using rbenv)
```
$ RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)"
```

Install Ruby 2.5.1
```
$ rbenv install 2.5.1
$ rbenv global 2.5.1
```

Install bundler
```
$ gem install bundler
```

Install Rails 5.2.3
```
$ gem install rails --version='5.2.3'
$ rbenv rehash
```

Install dependencies
```
$ bundle install

# If MySQL is not connecting
$ gem install mysql2 -v '0.5.2' -- --with-cppflags=-I/usr/local/opt/openssl/include --with-ldflags=-L/usr/local/opt/openssl/lib

```

Create and migrate database
```
$ rails db:create
$ rails db:migrate
```

## Vue.js Setup

```
# Install dependencies
$ bundle install
$ brew install yarn

# Initialize Webpacker and Vue
$ bundle exec rails webpacker:install
$ bundle exec rails webpacker:install:vue

# Run webpack-dev-server for live compiling
$ bin/webpack-dev-server
```

# Database Relation

## companies　table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :users


## users table
|Column|Type|Options|
|------|----|-------|
|user_number|integer|null: false|
|user_name|string|null: false|
|company_id|references|null: false, foreign_key: true|

### Association
- has_many :ideas
- has_many :plans
- has_many :idea_memos
- has_many :comments


## ideas table
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|content|text|null: false|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_many :idea_memos
- has_many :comments
- has_one :pran


## plans table
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|content|text|null: false|
|user_id|references|null: false, foreign_key: true|
|idea_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :idea


## memos table
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|idea_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :idea


## comments table
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|user_id|references|null: false, foreign_key: true|
|idea_id|references|null: false, foreign_key: true|


### Association
- belongs_to :user
- belongs_to :idea


## plan_questions table
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|



### Association
- has_many :plans

