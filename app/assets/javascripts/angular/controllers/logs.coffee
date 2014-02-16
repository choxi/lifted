# ##################################################################
angular.module("Lifted", ["ngResource", "highcharts-ng"]).controller "LogsController", ["$scope", "$http", ($scope, $http) ->
  window.scope = $scope

  $scope.refreshChart = =>
    $http.get("/api/v1/logs.json").success (response) =>
      $scope.logs = response
      $scope.chartConfig =
        options:
          chart:
            type: "column"
        xAxis:
          type: 'datetime',
          dateTimeLabelFormats:
            month: '%e. %b',
            year: '%b'

        series: $scope.mapLogsToDataSeries($scope.logs)
        title:
          text: "Weight"
        loading: false

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

  $scope.getWeightFromParameter = (name) ->
    if weight = $scope.getParameterByName(name)
      parseInt(weight)
    else
      0

  $scope.getParameterByName = (variable) ->
    query = window.location.search.substring(1)
    vars = query.split("&")
    i = 0

    while i < vars.length
      pair = vars[i].split("=")
      return pair[1]  if pair[0] is variable
      i++
    false

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

  $scope.newLog = {}
  $scope.newLog.exercises = [
    {name: "Squat",       weight: $scope.getWeightFromParameter("Squat")},
    {name: "Press",       weight: $scope.getWeightFromParameter("Press")},
    {name: "Bench Press", weight: $scope.getWeightFromParameter("Bench+Press")},
    {name: "Deadlift",    weight: $scope.getWeightFromParameter("Deadlift")},
  ]

  $scope.refreshChart()

  $scope
]