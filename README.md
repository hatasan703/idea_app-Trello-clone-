## ローカル

rbenvでrubyのインストール<br>
`$ RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)"`
`$ rbenv install 2.5.1`

ローカルのrubyのバージョン指定<br>
`rbenv global 2.5.1`

rubyのバージョンの確認<br>
`$ ruby -v`

bundlerのインストール<br>
`$ gem install bundler`

railsをインストール<br>
`$ gem install rails --version='5.2.3'`

rbenv再読み込み<br>
`$ rbenv rehash`

railsのバージョン確認<br>
`$ rails -v`


## クローン後

`bundle install`


mysqlが通らない場合<br>
`$ gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/' -- --with-cppflags=-I/usr/local/opt/openssl/include --with-ldflags=-L/usr/local/opt/openssl/lib`
