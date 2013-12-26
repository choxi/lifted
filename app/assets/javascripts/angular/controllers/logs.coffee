# ##################################################################
angular.module("Lifted", ["ngResource"]).controller "LogsController", ($scope, $http) ->
  window.scope = $scope

  $scope.newLog = {}
  $scope.newLog.exercises = [
    {name: "Squat", weight: 0},
    {name: "Press", weight: 0},
    {name: "Bench Press", weight: 0},
    {name: "Deadlift", weight: 0},
  ]

  $scope.createLog = =>
    $http.post("/api/v1/logs.json", log: $scope.newLog).success (response) =>
