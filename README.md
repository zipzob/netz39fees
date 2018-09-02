# Netz39Fees

## Project setup

### Install RVM

- https://rvm.io/rvm/install

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
```

### Install Ruby XXX

- Based on dependencies:
	- Rails 3.2.12
- we need:
	- Ruby 2.4.1

- https://rvm.io/rubies/installing	

```
rvm install 2.4.1
```
	
### Get source code

```
git clone git@github.com:netz39/netz39fees.git
cd netz39fees
# ...
rm Gemfile.lock
bundle install
# ...
rake db:setup RAILS_ENV=development
rake db:seed RAILS_ENV=development
# ... develop ... and eventually do
rake db:migrate RAILS_ENV=development

# Start server
ruby script/rails server

# Open Browser at http://localhost:3000/ 
```

## Start server