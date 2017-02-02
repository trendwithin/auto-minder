var app = angular.module('vehicles', ['ngMessages']);

app.factory('socrataData', function($http, $q) {
  var getStreetParkingSigns =  function(coords) {
    var url = "https://data.seattle.gov/resource/atig-uucb.json?$where=within_circle(shape,"
    + coords.latitude + "," + coords.longitude + ", 100)";
    return $http.get(url).then(function(response) {
      return response.data;
    });
  };
  return {
    getStreetParkingSigns: getStreetParkingSigns
  };
});

app.factory('vehicleCoordinates', function($q) {
  var service = {};
  var formData = {};

  service.getGeolocationCoordinates = function() {
    var deferred = $q.defer();
    navigator.geolocation.getCurrentPosition(
      function(position) { deferred.resolve(position.coords); },
      function(error) { deferred.resolve(null); }
    );
    return deferred.promise;
  };

  service.setCoords = function(coordsData){
      // assigns the coordinates to the form data- Return Data for Google Maps API
      formData.latitude = coordsData.latitude;
      formData.longitude = coordsData.longitude;
      return coordsData;
    };
  return service;
});

// TagMyVehiclesController
app.controller('TagMyVehiclesController', function ($scope, $http, $window, vehicleCoordinates, socrataData) {
  vehicleCoordinates.getGeolocationCoordinates().then(vehicleCoordinates.setCoords).then(buildMap);
  $scope.formData = {};
  function buildMap(coords) {
    $scope.formData.latitude = coords.latitude;
    $scope.formData.longitude = coords.longitude;
    var mapOptions = {
      zoom: 18,
      center: new google.maps.LatLng(coords.latitude, coords.longitude),
    }
    $scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);
    $scope.marker = new google.maps.Marker( {
      position: {lat: coords.latitude, lng: coords.longitude },
      map: $scope.map,
      title: 'Approximate Location of Vehicle.',
      label: 'Your Vehicle',
      icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
    });
    socrataData.getStreetParkingSigns(coords).then(function(data) {
      $scope.signs = data;
      console.log($scope.signs);
      angular.forEach(data, function(value, key) {
        $scope.marker = new google.maps.Marker( {
          position: new google.maps.LatLng(value.shape_lat, value.shape_lng ),
          map: $scope.map,
          title: value.categorydescr,
        });
      });
    }).catch(function() {
      $scope.error = 'Unable to access data.';
    });
    document.getElementById('loader').style.display = 'none';
    $scope.vehicleMapped = true; // show Submit Button when Map Renders
  }
  $scope.submitVehicle = function() {
    $http( {
      method: 'POST',
      url: '/tag_my_vehicles.json',
      data: $scope.formData,
      headers: { 'Content-Type': 'application/json' }
    }).then(function(data) {
      // on success redirect
      $window.location.href = '/tag_my_vehicles/show';
    });
  };
});


app.controller('VehicleInputCtrl', function ($scope, $q, $http, $window) {
  var longitude, latitude, coords;

  $scope.formData = {};
  // Invoke, scope coordinates for form, create new Google Map
  getGeolocationCoordinates()
    .then(setCoords)
    .then(buildMap);

  // Geolocation Coordinates
  function getGeolocationCoordinates() {
    var deferred = $q.defer();
    navigator.geolocation.getCurrentPosition(
      function(position) { deferred.resolve(position.coords); },
      function(error) { deferred.resolve(null); }
    );
    return deferred.promise;
  }

  function setCoords(coordsData){
    // assigns the coordinates to the form data- Return Data for Google Maps API
    $scope.formData.latitude = coordsData.latitude;
    $scope.formData.longitude = coordsData.longitude;
    return coordsData;
  }

  function buildMap(coords) {
    var mapOptions = {
      zoom: 18,
      center: new google.maps.LatLng(coords.latitude, coords.longitude),
    }
    $scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);
    $scope.marker = new google.maps.Marker( {
      position: {lat: coords.latitude, lng: coords.longitude },
      map: $scope.map,
      title: 'Approximate Location of Vehicle.'
    });
    document.getElementById('loader').style.display = 'none';
    $scope.vehicleMapped = true; // show Submit Button when Map Renders
  }

  $scope.submitVehicle = function() {
    $http( {
      method: 'POST',
      url: '/geo_tag_vehicles.json',
      data: $scope.formData,
      headers: { 'Content-Type': 'application/json' }
    }).then(function(data) {
      // on success redirect
      $window.location.href = '/geo_tag_vehicles/show';
    }); // need to handle failure
  };
}); // end controller
