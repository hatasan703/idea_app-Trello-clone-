## 事前にローカルで行うこと

mysqlのインストール

rbenvでrubyのインストール  
`$ RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)"`
`$ rbenv install 2.5.1`

全体で利用するバージョンを変更
`rbenv global 2.5.1`

rubyのバージョンの確認  
`$ ruby -v`

bundlerのインストール  
`$ gem install bundler`

railsをインストール  
`$ gem install rails --version='5.2.3'`

rbenv再読み込み  
`$ rbenv rehash`

railsのバージョン確認  
`$ rails -v`


## クローン後

`bundle install`

mysqlが通らない場合  
`$ gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/' -- --with-cppflags=-I/usr/local/opt/openssl/include --with-ldflags=-L/usr/local/opt/openssl/lib`

dbの作成  
`$ rails db:create`

マイグレート  
`$ rails db:migrate`


# DB設計

## companiesテーブル
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


##　ideas table
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
|content|text|null: false|
|user_id|references|null: false, foreign_key: true|
|idea_id|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :idea


## idea_memos table
- content
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
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




