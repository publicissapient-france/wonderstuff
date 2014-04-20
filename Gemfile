source 'https://rubygems.org'

group :lint do
  gem 'foodcritic', '~> 3.0'
  gem 'rubocop', '~> 0.18'
  gem 'rake'
end

group :unit do
  gem 'berkshelf',  '~> 3.1'
  gem 'chefspec',   '~> 3.1'
  gem 'rspec-expectations'
  gem 'cucumber'
end

group :kitchen_common do
  gem 'test-kitchen', '~> 1.2'
end

group :kitchen_vagrant do
  gem 'kitchen-vagrant', '~> 0.11'
end

group :kitchen_cloud do
  gem 'kitchen-digitalocean'
end

group :development do
  gem 'guard', '~> 2.4'
  gem 'guard-kitchen'
  gem 'guard-foodcritic', '~> 1.0'
  gem 'guard-rspec', '~> 4.2'
  gem 'guard-rubocop'
end
