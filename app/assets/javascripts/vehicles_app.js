var app = angular.module('vehicles', []);

app.controller('VehicleInputCtrl', function ($scope, $q) {
  var longitude, latitude, coords;

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
    $scope.latitude = coordsData.latitude;
    $scope.longitude = coordsData.longitude;
    return coordsData;
  }

  function buildMap(coords) {
    var mapOptions = {
      zoom: 18,
      center: new google.maps.LatLng(coords.latitude, coords.longitude),
    }
    $scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);
    $scope.marker = new google.maps.Marker( {
      position: {lat: $scope.latitude, lng: $scope.longitude },
      map: $scope.map,
      title: 'Approximate Location of Vehicle.'
    });
    document.getElementById('loader').style.display = 'none';
    $scope.vehicleMapped = true; // show Submit Button when Map Renders
  }
}); // end controller
