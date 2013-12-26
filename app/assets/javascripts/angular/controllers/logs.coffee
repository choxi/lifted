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
      $scope.logs = response
      $scope.chartConfig =
        options:
          chart:
            type: "area"
        xAxis:
          type: 'datetime',
          dateTimeLabelFormats:
            month: '%e. %b',
            year: '%b'

        series: $scope.mapLogsToDataSeries($scope.logs)
        title:
          text: "Weight"

  $scope.createLog = =>
    $http.post("/api/v1/logs.json", log: $scope.newLog).success (response) =>
      $scope.refreshChart()

  $scope.timestampToUTC = (timestamp) =>
    date = new Date(timestamp)
    Date.UTC(date.getYear(), date.getMonth(), date.getDate())

  $scope.exerciseWeightFromLog = (log, exerciseName) =>
    exercise = (log.exercises.filter (e) -> e.name == exerciseName)[0]
    if exercise?
      exercise.weight
    else
      "-"

  $scope.mapLogsToDataSeries = (logs) =>
    data = {}

    # map the logs to something that looks like:
    #
    # {
    #   "Squats": [[<date>, <weight], [<date>, <weight>]],
    #   "Deadlift": [[<date>, <weight]]
    # }
    for log in logs
      for exercise in log.exercises
        data[exercise.name] = [] unless data[exercise.name]?
        data[exercise.name].push([$scope.timestampToUTC(log.created_at), exercise.weight])

    $.map data, (data, name) ->
      {name: name, data: data}

  $scope.refreshChart()

  $scope