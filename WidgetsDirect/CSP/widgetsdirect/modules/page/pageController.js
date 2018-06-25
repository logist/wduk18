angular
  .module('WidgetsDirect')
   .controller('PageController', ['$q', '$scope', '$timeout', '$http', '$log', function($q, $scope, $timeout, $http, $log) {
	
	$scope.message = "";
	$scope.sortAsc = true;
	
	
	
	$http.get('/widgetsdirect/rest/UK Meetup').then(
	  function(response) { //success
	    $scope.message = response.data.Message;
	    
      }
     ,function(response) { //failure
	   $scope.message = "Couldn't get data :(";
       }
      );
      
      $http.get('/widgetsdirect/rest/').then(
	  function(response) { //success
	   
	    $scope.widgets = response.data.Widgets;
      }
     ,function(response) { //failure
	   $scope.widgets = [];
       }
      );
	   
   		}
   	  ]
   )