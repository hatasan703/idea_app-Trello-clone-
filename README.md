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
