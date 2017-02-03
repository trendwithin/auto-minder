# Autominder

## Rails 5.0.1 w/ Angular 1.5, and BootStrap 3, and PG

### About:
Living in a high traffic neighborhood in Seattle, come Wednesday when tickets have piled up and boots locked to a wheelbase, I've often wonderd how many of these vehicles were forgotten or stolen.  **Autominder** is a Rails application intended to make use of crowd sourcing commuters to reunite abandoned, lost/stolen, or forgotten vehicles with thier owners.  

Using HTML5 Geolocation along with a simple form, users can mark the approximate location of a vehicle that is receiving an excessive amount of parking tickets or has been booted.


![GeoTagVehicle](https://cloud.githubusercontent.com/assets/8145031/22574945/36756b64-e967-11e6-8052-525429f66fdf.png)

To encourage participation users can tag the location of their vehicle and will be provided with a list and location of registered street signs on record with SDOT.  Whether being replaced, defaced, destroyed, or hidden behind overgrowth, users can now be informed of the parking restrictions within their vicinity.  

![TagMyVehicle](https://cloud.githubusercontent.com/assets/8145031/22574948/3bb1bb46-e967-11e6-888a-0c4bd8c88d12.png)

####Future Features:
* Improve Vehicle Search
* Email alert for vehicle
*

#### Setup Instructions
````
clone repo
bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec bower:install
bundle exec rake
````
