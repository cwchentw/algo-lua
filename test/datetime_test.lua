local DateTime = require("algo.DateTime")
local DateTimeDuration = require("algo.DateTimeDuration")

-- 2017/3/5 12:34:50
do
  local d = DateTime:new({
      year = 2017, month = 3, day = 5,
      hour = 12, minute = 34, second = 50,
    })
  assert(d:year() == 2017)
  assert(d:month() == 3)
  assert(d:day() == 5)
  assert(d:hour() == 12)
  assert(d:minute() == 34)
  assert(d:second() == 50)
  assert(d:era() == "ce")
end

-- 1970/1/1 00:00:00 (Unix epoch time)
do
  local d = DateTime:new({ year = 1970, }, {})
  assert(d:year() == 1970)
  assert(d:month() == 1)
  assert(d:day() == 1)
  assert(d:hour() == 0)
  assert(d:minute() == 0)
  assert(d:second() == 0)
  assert(d:era() == "ce")
end

-- DateTime addition within minutes
do
  local d1 = DateTime:new({
      year = 2017,
      month = 3,
      day = 31,
      hour = 23,
      minute = 40,
      second = 55,
    })
  local d2 = DateTimeDuration:new({
      minute = 30,
      second = 25,
    })
  
  local d = d1 + d2
  assert(d:year() == 2017)
  assert(d:month() == 4)
  assert(d:day() == 1)
  assert(d:hour() == 0)
  assert(d:minute() == 11)
  assert(d:second() == 20)
end

-- DateTime addition beyond one year
do
    local d1 = DateTime:new({
      year = 2017,
      month = 3,
      day = 31,
      hour = 23,
      minute = 40,
      second = 55,
    })
  local d2 = DateTimeDuration:new({
      year = 1,
      month = 11,
      day = 2,
      hour = 15,
      minute = 30,
      second = 25,
    })
  
  local d = d1 + d2
  assert(d:year() == 2019)
  assert(d:month() == 3)
  assert(d:day() == 1)
  assert(d:hour() == 15)
  assert(d:minute() == 11)
  assert(d:second() == 20)
end