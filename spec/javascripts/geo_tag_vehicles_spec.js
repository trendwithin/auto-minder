describe('VehicleInputCtrl', function () {
  var $window, navigator;
  describe("Initialization", function() {
    var scope = null, controller = null;

    beforeEach(module('vehicles'));

    beforeEach(inject(function ($controller, $rootScope) {
      scope = $rootScope.$new();
      controller = $controller('VehicleInputCtrl', {
        $scope: scope
      });
    }));
    // test
  });
});
