local DateTimeDuration = require("algo.DateTimeDuration")

do
  local duration = DateTimeDuration:new({
      year = 1,
      month = 3,
      day = 15,
      hour = 6,
      minute = 54, 
      second = 30,
    })
  print(duration:to_day())
end