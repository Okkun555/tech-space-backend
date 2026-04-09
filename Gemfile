source "https://rubygems.org"

gem "bcrypt", "~> 3.1.22"
gem "blueprinter"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rack-cors"
gem "rails", "~> 8.1.2"
gem 'rails-i18n'
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "image_processing", "~> 1.2"

group :development, :test do
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "factory_bot_rails"
  gem "faker"
  gem 'pry-rails'
  gem 'pry-byebug'
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails"
end

group :test do
  gem "shoulda-matchers"
end
