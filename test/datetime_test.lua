local DateTime = require("algo.DateTime")

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
end

-- Default to 1970/1/1 00:00:00
do
  local d = DateTime:new({}, {})
  assert(d:year() == 1970)
  assert(d:month() == 1)
  assert(d:day() == 1)
  assert(d:hour() == 0)
  assert(d:minute() == 0)
  assert(d:second() == 0)
end
