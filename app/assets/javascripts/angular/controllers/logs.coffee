# ##################################################################
angular.module("Lifted", ["ngResource", "highcharts-ng"]).controller "LogsController", ($scope, $http) ->
  window.scope = $scope

  $scope.newLog = {}
  $scope.newLog.exercises = [
    {name: "Squat", weight: 0},
    {name: "Press", weight: 0},
    {name: "Bench Press", weight: 0},
    {name: "Deadlift", weight: 0},
  ]

  $scope.refreshChart = =>
    $http.get("/api/v1/logs.json").success (response) =>
      $scope.logs = $.map response, (log) ->
        [new Date(log.created_at), log.exercises[0].weight]

      $scope.chartConfig =
        options:
          chart:
            type: "line"
        xAxis:
          type: 'datetime',
          dateTimeLabelFormats:
            month: '%e. %b',
            year: '%b'

        series: [{name: "Squat", data: $scope.logs}]
        title:
          text: "Weight"

  $scope.createLog = =>
    $http.post("/api/v1/logs.json", log: $scope.newLog).success (response) =>
