local DateTime = require("algo.DateTime")

do
  local date = DateTime:now()
  print("year: " .. date:year())
  print("month: " .. date:month())
  print("day: " .. date:day())
  print("hour: " .. date:hour())
  print("minute: " .. date:minute())
  print("second: " .. date:second())
  print("tz: " .. date:tz())
end