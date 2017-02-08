local Time = require("algo.Time")

-- 24-clock Time object, before 12:00 pm
do
  local t = Time:new({day = 1, hour = 11, minute = 59, second = 59})
  assert(t:day() == 1)
  assert(t:hour() == 11)
  assert(t:minute() == 59)
  assert(t:second() == 59)
end

-- 24-clock Time object, after 12:00 pm
do
  local t = Time:new({day = 1, hour = 23, minute = 59, second = 59})
  assert(t:day() == 1)
  assert(t:hour() == 23)
  assert(t:minute() == 59)
  assert(t:second() == 59)
end

-- 12-clock Time object, before 12:00 pm
do
  local t = Time:new({day = 1, hour = 11, minute = 59, second = 59},
                     {system = "12-clock", period = "am"})
  assert(t:day() == 1)
  assert(t:hour() == 11)
  assert(t:minute() == 59)
  assert(t:second() == 59)
end

-- 12-clock Time object, after 12:00 pm
do
  local t = Time:new({day = 1, hour = 11, minute = 59, second = 59},
                     {system = "12-clock", period = "pm"})
  assert(t:day() == 1)
  assert(t:hour() == 23)
  assert(t:minute() == 59)
  assert(t:second() == 59)
end
