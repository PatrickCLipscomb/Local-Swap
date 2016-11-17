#  Local Swap
## *By Patrick Lipscomb*

Local Swap is a complex application that allows users to create profiles and trade items with other users via a geographically and socially enabled environment. Users locations are hidden via a location scrambling function that offsets their given location by up to 500 ft. Directions are available for users to locate other users, but those directions will never point to a users true location. In this way users locations are used as an asset to the application but not made available for other users.

##  Important Notice

When logging in for the first time, use *Email: local@swap.app*  *Password: password*  
The database must first be seeded for this to work, and it will allow you to access all features, including the ReactJS Admin Dashboard.

## Technologies Used

* **Application**: *Ruby on Rails 5, ReactJS*<br>
* **Testing**: *Rspec, Capybara, Simplecov, FactoryGirl, PhantomJS, Poltergeist*<br>
* **Database**: *Postgres, ActiveRecord*

Installation
------------

Install *Local Swap* by cloning the repository.  
```
$ git clone https://github.com/PatrickCLipscomb/Local-Swap.git
```

Check to make sure ruby and rails are installed on your machine.  
```
$ ruby -v
$ rails -v
```
If they are not installed, please follow instructions [here](http://guides.rubyonrails.org/getting_started.html#installing-rails) to install ruby on rails.

Install required gems:
```
$ bundle install
```

Run Postgres:
```
$ postgres
```

Navigate to project file then create, migrate and seed database:
```
$ rake db: create
$ rake db: migrate
$ rake db: seed
```

Start the Rails webserver:
```
$ rails server
```

Navigate to `localhost:3000` in your browser of choice.

License
-------
_This software is licensed under the MIT license._<br>
Copyright (c) 2016 **Patrick Lipscomb**
