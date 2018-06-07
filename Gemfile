source 'https://rubygems.org'

gem 'rails',        '5.1.4'
# need bcrypt to hash password
gem 'bcrypt',         '3.1.11'
# 実際にいそうなユーザー名を作成するgem
# go to db/seeds.rb next
gem 'faker',          '1.7.3'
# 画像アップローダー
gem 'carrierwave',             '1.2.2'
# 画像をリサイズ
gem 'mini_magick',             '4.7.0'
# add following 2 to use paginate method
# (show only a limited number of users at one time)
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
# Adding Bootstrap (LESS->Sass)
# Don't forget to execute "bundle install when adding sth to Gemfile"
# Can use LESS variables (https://getbootstrap.com/docs/3.3/customize/)
gem 'bootstrap-sass', '3.3.7'
gem 'puma',         '3.9.1'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'
# add gem for mysql when using mysql instead of sqlite3

group :development, :test do
  # remove the following code when using sqlite3
  gem 'sqlite3', '1.3.13'
  # debug console (byebug) will be shown to server screen
  # makes it easy to debug by checking current states or info
  gem 'byebug',  '9.0.6', platform: :mri

  # Rspec Test
  gem 'rspec-rails', '~> 3.7'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

group :production do
  gem 'pg', '0.20.0'
  gem 'fog', '1.42'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]