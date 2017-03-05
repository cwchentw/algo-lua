--- algo.DateTime class.
-- A simple DateTime class based on Gregorian calendar.  Currently, there is a trend
-- replacing BC (before Christ)/AD (anno Domini, in the year of Our Lord) with
-- BCE (before the current era)/CE (current era) due to religious issues.  This class
-- adopts both conventions.
-- @classmod DateTime
local DateTime = {}
package.loaded['DateTime'] = DateTime

DateTime.__index = DateTime

local function _get_datetime(table)
  local t = {}
  
  if table["year"] == nil then
    t["year"] = 1970
  else
    t["year"] = table["year"]
  end
  
  if table["month"] == nil then
    t["month"] = 1
  else
    t["month"] = table["month"]
  end
  
  if table["day"] == nil then
    t["day"] = 1
  else
    t["day"] = table["day"]
  end
  
  if table["hour"] == nil then
    t["hour"] = 0
  else
    t["hour"] = table["hour"]
  end
  
  if table["minute"] == nil then
    t["minute"] = 0
  else
    t["minute"] = table["minute"]
  end
  
  if table["second"] == nil then
    t["second"] = 0
  else
    t["second"] = table["second"]
  end
  
  return t
end

local function _get_option(option)
  local _option = {}
  
  if option["era"] == nil then
    _option["era"] = "ce"
  elseif option["era"] == "ac" then
    _option["era"] = "ce"
  elseif option["era"] == "bc" then
    _option["era"] = "bce"
  elseif option["era"] == "bce" or option["era"] == "ce" then
    _option["era"] = option["era"]
  else
    error("Unknown era")
  end
  
  if option["tz"] == nil then
    _option["tz"] = os.date("%z")
  else
    _option["tz"] = option["tz"]
  end
  
  if option["system"] == nil then
    _option["system"] = "24-clock"
  else
    assert(option["system"] == "12-clock" or option["system"] == "24-clock")
    _option["system"] = option["system"]
  end
  
  if _option["system"] == "12-clock" then
    assert(option["period"] == "am" or option["period"] == "pm")
    _option["period"] = option["period"]
  end
  
  return _option
end

local function _convert_hour(h, p)
  local _h = h
  if _h == 12 then
    _h = 0
  end

  if p == "pm" then
    _h = _h + 12
  end

  return _h
end

local function _is_leap_year(y)
  if y % 400 == 0 then
    return true
  elseif y % 100 == 0 then
    return false
  elseif y % 4 == 0 then
    return true
  else
    return false
  end
end

--- Create a new DateTime object.
-- @param table A table present datetime.  Available parameters includes:
--
-- * year: integer.  It could be bc (bce) or ac (ce)
-- * month: 1 <= month <= 12, integer
-- * day: integer starting from 1, the range varies according to month.
-- * hour: 0 <= hour < 24, integer
-- * minute: 0 <= minute < 60, integer
-- * second: 0 <= second < 60, integer
--
-- @param option (Optional) A table presents options. Available options includes:
--
-- * era: either bc/bce or ac/ce.  Default to ac/ce.
-- * tz: in UTC format, e.g. +0800.  If not specified, it will assume local time.
-- * system: either "12-clock" or "24-clock".  Default to 24-clock.
-- * period: either "am" or "pm"  Mandatory when on "12-clock" system.
--
-- @return A DateTime object
function DateTime:new(table, option)
  local _table = _get_datetime(table)
  local _option
  if option == nil then
    _option = _get_option({})
  else
    _option = _get_option(option)
  end
  
  self = {}
  setmetatable(self, DateTime)

  self._year = _table["year"]
  assert(self._year % 1 == 0)
  
  self._month = _table["month"]
  assert(self._month % 1 == 0 and 1 <= self._month and self._month <= 12)
  
  self._day = _table["day"]
  assert(self._day % 1 == 0)
  local days_by_month = {
    31, 28, 31, 30, 31, 30,
    31, 31, 30, 31, 30, 31,
  }
  if _is_leap_year(self._year) and self._month == 2 then
    assert(1 <= self._day and self._day <= 29)
  else
    assert(1 <= self._day and self._day <= days_by_month[self._month])
  end
  
  -- Internally, we use 24-clock to present hour.
  if _option["system"] == "12-clock" then
    self._hour = _convert_hour(_table["hour"], _option["period"])
  else
    self._hour = _table["hour"]
  end
  assert(self._hour % 1 == 0 and 0 <= self._hour and self._hour < 24)
  
  self._minute = _table["minute"]
  assert(self._minute % 1 == 0 and 0 <= self._minute and self._minute < 60)
  
  self._second = _table["second"]
  assert(self._second % 1 == 0 and 0 <= self._second and self._second < 60)
  
  self._era = _option["era"]
  self._tz = _option["tz"]
  self._system = _option["system"]
  self._period = _option["period"]
  
  return self
end

--- Get the year of the DateTime object.
-- @return year (number)
function DateTime:year()
  return self._year
end

--- Get the month of the DateTime object.
-- @return month (number, 1 <= month <= 12)
function DateTime:month()
  return self._month
end

--- Get the day of the DateTime object.
-- @return day (number, the range varies according to month)
function DateTime:day()
  return self._day
end

--- Get the hour of the DateTime object.
-- @return hour (number, 0 <= hour < 24)
function DateTime:hour()
  return self._hour
end

--- Get the minute of the DateTime object.
-- @return minute (number, 0 <= minute < 60)
function DateTime:minute()
  return self._minute
end

--- Get the second of the DateTime object.
-- @return second (number, 0 <= second < 60)
function DateTime:second()
  return self._second
end

return DateTime