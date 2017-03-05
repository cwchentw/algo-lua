--- algo.DateTime class.
-- A simple DateTime class based on Gregorian calendar.  Currently, there is a trend
-- replacing BC (before Christ)/AD (anno Domini, in the year of Our Lord) with
-- BCE (before the current era)/CE (current era) due to religious issues.  This class
-- adopts both conventions.
-- @classmod DateTime
local DateTimeDuration = require("algo.DateTimeDuration")
local DateTime = {}
package.loaded['DateTime'] = DateTime

DateTime.__index = DateTime

local days_by_month = {
  31, 28, 31, 30, 31, 30,
  31, 31, 30, 31, 30, 31,
}

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

local function _convert_datetime(year, month, day, hour, minute, second)
  local y = year
  local mon = month - 1
  local d = day - 1
  local h = hour
  local min = minute
  local s = second
  
  if s > 0 then
    while s > 59 do
      min = min + 1
      s = s - 60
    end
  elseif s < 0 then
    while s < 0 do
      min = min - 1
      s = s + 60
    end
  end
  
  if min > 0 then
    while min > 59 do
      h = h + 1
      min = min - 60
    end
  elseif min < 0 then
    while min < 0 do
      h = h - 1
      min = min + 60
    end
  end
  
  if h > 0 then
    while h > 23 do
      d = d + 1
      h = h - 24
    end
  elseif h < 0 then
    while h < 0 do
      d = d - 1
      h = h + 24
    end
  end
  
  if d > 0 then
    while true do
      local n
      if _is_leap_year(y) and mon == 2 then
        n = 29
      else
        n = days_by_month[mon]
      end

      if d > n then
        mon = mon + 1
        d = d - n
      else
        break
      end
      
      if mon > 12 then
        y = y + 1
        mon = mon - 12
      end
    end
  elseif d < 0 then
    while true do
      local n
      if _is_leap_year(y) and (mon - 1) == 2 then
        n = 29
      elseif (mon - 1) == 0 then
        n = days_by_month[12]
      else
        n = days_by_month[mon - 1]
      end
      
      if d - 1 < 0 then
        mon = mon - 1
        d = d + n
      else
        break
      end
    end
  end
  
  if mon > 0 then
    while mon > 11 do
      y = y + 1
      mon = mon - 12
    end
  elseif mon - 1 < 0 then
    while mon < 0 do
      y = y - 1
      mon = mon + 12
    end
  end
  
  local era
  if y < 0 then
    era = "bce"
    y = -y
  else
    era = "ce"
  end
  
  return y, mon + 1, d + 1, h, min, s, era
end

local function _get_utc_offset(tz)
  local str = {}
  for i = 1, 5 do
    str[i] = tz:sub(i, i)
  end
  
  assert(str[1] == "+" or str[1] == "-")
  
  local hour = tonumber(str[2]) * 10 + tonumber(str[3])
  local min = tonumber(str[4]) * 10 + tonumber(str[5])
  return hour, min
end

--- Add a DateTime object with a DateTimeDuration object
-- @param a A DateTime object.
-- @param b A DateTimeDuratioon object.
-- @return A new DateTime object.
DateTime.__add = function (a, b)
  assert(type(a) == "table")
  assert(type(b) == "table")
  
  -- Convert a to UTC datetime
  local h_offset_a, m_offset_a = _get_utc_offset(a:tz())
  local y_a, mon_a, d_a, h_a, min_a, s_a, era_a = _convert_datetime(
    a._year, a._month, a._day, 
    a._hour + h_offset_a, a._minute + m_offset_a, a._second)
  if era_a == "bce" then
    y_a = -y_a
  end
  
  -- b is a datetime duration
  local y_b, mon_b, d_b, h_b, min_b, s_b = 
    b:year(), b:month(), b:day(), b:hour(), b:minute(), b:second()
  
  local y, mon, d, h, min, s, era = _convert_datetime(
    y_a, mon_a, d_a + d_b,
    h_a + h_b, min_a + min_b, s_a + s_b)
  if era == "bce" then
    y = -y
  end
  
  mon = mon + mon_b
  if mon > 0 then
    while mon > 12 do
      mon = mon - 12
      y = y + 1
    end
  else
    while mon < 1 do
      mon = mon + 12
      y = y - 1
    end
  end
  y = y + y_b
  if y < 0 then
    era = "bce"
    y = -y
  else
    era = "ce"
  end

  local date = DateTime:new({
    year = y,
    month = mon,
    date = d,
    hour = h,
    minute = min,
    second = s,
  }, {
    era = era,
    tz = "+0000",
  })

  return date:conv_tz(a:tz())
end

local function _get_datetime(table)
  local t = {}
  
  if table["year"] == nil then
    t["year"] = 0
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
    _option["tz"] = "+0000"
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
-- * tz: in UTC format, e.g. +0800.  If not specified, it will be UTC time.
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
  assert(self._month % 1 == 0 and 0 <= self._month and self._month <= 12)
  
  self._day = _table["day"]
  assert(self._day % 1 == 0)

  if _is_leap_year(self._year) and self._month == 2 then
    assert(0 <= self._day and self._day <= 29)
  elseif 1 <= self._month and self._month <= 12 then
    assert(0 <= self._day and self._day <= days_by_month[self._month])
  else
    assert(0 <= self._day)
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

function DateTime:diff(date)
  local h_offset_a, m_offset_a = _get_utc_offset(self._tz)
  local y_a, mon_a, d_a, h_a, min_a, s_a, era_a = _convert_datetime(
    self._year, self._month, self._day,
    self._hour + h_offset_a, self._minute + m_offset_a, self._second)

  local h_offset_b, m_offset_b = _get_utc_offset(self._tz)
  local y_b, mon_b, d_b, h_b, min_b, s_b, era_b = _convert_datetime(
    date._year, date._month, date._day,
    date._hour + h_offset_b, date._minute + m_offset_b, date._second)
  
  local year = 0
  local month = 0
  local day = 0
  local hour = 0
  local minute = 0
  local second = 0
  
  second = second + s_a - s_b
  while second < 0 do
    minute = minute - 1
    second = second + 60
  end
  
  minute = minute + min_a - min_b
  while minute < 0 do
    hour = hour - 1
    minute = minute + 60
  end
  
  hour = hour + h_a - h_b
  while hour < 0 do
    day = day - 1
    hour = hour + 24
  end
  
  day = day + d_a - d_b
  while true do
    local n
    if _is_leap_year(y_a) and (mon_a - 1) == 2 then
      n = 29
    else
      n = days_by_month[mon_a - 1]
    end
    
    if day < 0 then
      month = month - 1
      day = day + n
    else
      break
    end
    
    while month < 0 do
      year = year - 1
      month = month + 12
    end
  end
  
  month = month + mon_a - mon_b
  while month < 0 do
    year = year - 1
    month = month + 12
  end
  
  year = year + y_a - y_b
  
  local duration = DateTimeDuration:new({
      year = year,
      month = month,
      day = day,
      hour = hour,
      minute = minute,
      second = second,
    })
  
  return duration
end

--- Get the year of the DateTime object.
-- @param utc (Optional).  If true, return year in UTC.
-- @return year (number)
function DateTime:year(utc)
  if utc == nil or utc == false then
    return self._year
  end
  
  local h, m = _get_utc_offset(self._tz)
  local y, mon, d, h_utc, min, s = _convert_datetime(
    self._year, self._month, self._day,
    self._hour + h, self._minute + m, self._second)
  
  return y
end

--- Get the month of the DateTime object.
-- @param utc (Optional).  If true, return month in UTC.
-- @return month (number, 1 <= month <= 12)
function DateTime:month(utc)
  if utc == nil or utc == false then
    return self._month
  end
  
  local h, m = _get_utc_offset(self._tz)
  local y, mon, d, h_utc, min, s = _convert_datetime(
    self._year, self._month, self._day,
    self._hour + h, self._minute + m, self._second)
  
  return mon
end

--- Get the day of the DateTime object.
-- @param utc (Optional).  If true, return day in UTC.
-- @return day (number, the range varies according to month)
function DateTime:day(utc)
  if utc == nil or utc == false then
    return self._day
  end
  
  local h, m = _get_utc_offset(self._tz)
  local y, mon, d, h_utc, min, s = _convert_datetime(
    self._year, self._month, self._day,
    self._hour + h, self._minute + m, self._second)
  
  return d
end

--- Get the hour of the DateTime object.
-- @param utc (Optional).  If true, return hour in UTC.
-- @return hour (number, 0 <= hour < 24)
function DateTime:hour(utc)
  if utc == nil or utc == false then
    return self._hour
  end
  
  local h, m = _get_utc_offset(self._tz)
  local y, mon, d, h_utc, min, s = _convert_datetime(
    self._year, self._month, self._day,
    self._hour + h, self._minute + m, self._second)
  
  return h_utc
end

--- Get the minute of the DateTime object.
-- @param utc (Optional).  If true, return minute in UTC.
-- @return minute (number, 0 <= minute < 60)
function DateTime:minute(utc)
  if utc == nil or utc == false then
    return self._minute
  end
  
  local h, m = _get_utc_offset(self._tz)
  local y, mon, d, h_utc, min, s = _convert_datetime(
    self._year, self._month, self._day,
    self._hour + h, self._minute + m, self._second)
  
  return min
end

--- Get the second of the DateTime object.
-- @return second (number, 0 <= second < 60)
function DateTime:second()
  return self._second
end

--- Get the era of the DateTime object.
-- @return era (string, "bce" or "ce")
function DateTime:era()
  return self._era
end

--- Get the time zone of the DateTime object.
-- @return time zone (string, e.g. "+0800")
function DateTime:tz()
  return self._tz
end

function DateTime:conv_tz(tz)
  local h_orig, m_orig = _get_utc_offset(self._tz)
  local h_new, m_new = _get_utc_offset(tz)
  local y, mon, d, h, min, s, era = _convert_datetime(
    self._year, self._month, self._day,
    self._hour + h_orig + h_new, self._minute + m_orig + m_new, self._second)
  local date = DateTime:new({
      year = y,
      month = mon, 
      date = d,
      hour = h,
      minute = min,
      second = s,
    }, {
      era = era,
      tz = tz,
    })
  return date
end

return DateTime