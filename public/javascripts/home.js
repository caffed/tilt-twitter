angular.module("tiltTwitterHome", [])

.controller("HomeCtrl", function($scope, Twitter, $timeout){
  var home = this;
  $scope.message = "Tilt Twitter Coding Challenge";

  // get latest tweets
  home.latest =  [];
  $scope.user = '';

  $scope.getTweets = function(user) {
    Twitter.tweets.get({ 'user' : user }).$promise.then(function(resp){
      home.latest = resp.tweets;
   });
  };

  // get user intersection
  home.intersection = [];

  $scope.getIntersection = function(user_one, user_two) {
    Twitter.intersection.get({'user_one' : user_one, 'user_two': user_two})
      .$promise.then(function(resp){
        home.intersection = resp.intersection;
      });
  };
})

;
