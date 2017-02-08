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

-- Time addition, less than one day.
do
  local t1 = Time:new({hour = 7, minute = 40, second = 50})
  local t2 = Time:new({hour = 5, minute = 30, second = 15})
  local t = t1 + t2
  assert(t:day() == 0)
  assert(t:hour() == 13)
  assert(t:minute() == 11)
  assert(t:second() == 5)
end

-- Time addition, larger than one day.
do
  local t1 = Time:new({hour = 18, minute = 30, second = 40})
  local t2 = Time:new({hour = 8, minute = 40})
  local t = t1 + t2
  assert(t:day() == 1)
  assert(t:hour() == 3)
  assert(t:minute() == 10)
  assert(t:second() == 40)
end

-- Time substration, less than one day.
do
  local t1 = Time:new({hour = 18, minute = 30, second = 40})
  local t2 = Time:new({hour = 8, minute = 40})
  local t = t1 - t2
  assert(t:day() == 0)
  assert(t:hour() == 9)
  assert(t:minute() == 50)
  assert(t:second() == 40)
end

-- Time substration, overnight
do
  local t1 = Time:new({hour = 5, minute = 30}) + Time:new({day = 1})
  local t2 = Time:new({hour = 22, minute = 50})
  local t = t1 - t2
  assert(t:day() == 0)
  assert(t:hour() == 6)
  assert(t:minute() == 40)
  assert(t:second() == 0)
end

-- Time substration, less than zero.
-- We might change the result in the future.
do
  local t1 = Time:new({hour = 5, minute = 30})
  local t2 = Time:new({hour = 22, minute = 50})
  local t = t1 - t2
  assert(t:day() == -1)
  assert(t:hour() == 6)
  assert(t:minute() == 40)
  assert(t:second() == 0)
end

-- Time to seconds.
do
  local t = Time:new({hour = 23, minute = 59, second = 59})
  assert(t:to_second() == 86399)
end
