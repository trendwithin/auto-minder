var app = angular.module('vehicles', ['ngMessages']);

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
