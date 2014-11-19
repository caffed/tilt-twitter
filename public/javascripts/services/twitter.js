angular.module("tiltTwitterService", [])

.service("Twitter", function($resource){
  return {
      tweets: $resource('/api/v1/:user/tweets.json', {
          user: '@user'
        }, {
          get: { method: 'GET', isArray: false}
        }),
      intersection: $resource('/api/v1/users/intersection.json', {
          user_one: '@user_one',
          user_two: '@user_two'
        }, {
          get: { method: 'GET', isArray: false}
        })
    };
})

;
