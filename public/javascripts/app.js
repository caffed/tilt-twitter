"use strict";

angular.module("TiltTwitter", ['ngRoute',
                               'ngResource',
                               'tiltTwitterHome',
                               'tiltTwitterService'])

.config(function($locationProvider, $routeProvider){
  $routeProvider

    .when('/home', {
      templateUrl: 'templates/home.html',
      controller: 'HomeCtrl as home'
    })

    .otherwise('/');

  $locationProvider.html5Mode(true);
})
;
