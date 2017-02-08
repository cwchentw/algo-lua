--- `algo.Time` class.
-- A Time class with no knowledge to date.  All time beyond 24 hours will be
-- converted to days.
-- @classmod Time
local Time = {}
package.loaded['algo.Time'] = Time

Time.__index = Time

local function _convert_time(d, h, m, s)
  local _s = s
  local _m = m
  local _h = h
  local _d = d

  if _s < 0 then
    repeat
      _m = _m - 1
      _s = _s + 60
    until _s >= 0
  elseif _s >= 60 then
    repeat
      _m = _m + 1
      _s = _s - 60
    until _s < 60
  end

  if _m < 0 then
    repeat
      _h = _h - 1
      _m = _m + 60
    until _m >= 0
  elseif _m >= 60 then
    repeat
      _h = _h + 1
      _m = _m - 60
    until _m < 60
  end

  if _h < 0 then
    repeat
      _d = _d - 1
      _h = _h + 24
    until _h >= 0
  elseif _h >= 24 then
    repeat
      _d = _d + 1
      _h = _h - 24
    until _h < 24
  end

  return _d, _h, _m, _s
end

Time.__unm = function (t)
  assert(type(t) == "table" and t["day"] and t["hour"] and
         t["minute"] and t["second"])
  local d, h, m, s = _convert_time(-t:day(), -t:hour(), -t:minute(), -t:second())
  return Time:new({day = d, hour = h, minute = m, second = s})
end

--- Time addition.
Time.__add = function (t1, t2)
  assert(type(t1) == "table" and t1["day"] and t1["hour"] and
         t1["minute"] and t1["second"])
  assert(type(t2) == "table" and t2["day"] and t2["hour"] and
         t2["minute"] and t2["second"])

  local d, h, m, s = _convert_time(t1:day() + t2:day(),
                                  t1:hour() + t2:hour(),
                                  t1:minute() + t2:minute(),
                                  t1:second() + t2:second())

  return Time:new({day = d, hour = h, minute = m, second = s})
end

--- Time substration.
Time.__sub = function (t1, t2)
  assert(type(t1) == "table" and t1["day"] and t1["hour"] and
         t1["minute"] and t1["second"])
  assert(type(t2) == "table" and t2["day"] and t2["hour"] and
         t2["minute"] and t2["second"])

  local d, h, m, s = _convert_time(t1:day() - t2:day(),
                                   t1:hour() - t2:hour(),
                                   t1:minute() - t2:minute(),
                                   t1:second() - t2:second())

  return Time:new({day = d, hour = h, minute = m, second = s})
end

local function _get_time(t)
  local _t = {}
  if t["day"] == nil then
    _t["day"] = 0
  else
    _t["day"] = t["day"]
  end

  if t["hour"] == nil then
    _t["hour"] = 0
  else
    _t["hour"] = t["hour"]
  end

  if t["minute"] == nil then
    _t["minute"] = 0
  else
    _t["minute"] = t["minute"]
  end

  if t["second"] == nil then
    _t["second"] = 0
  else
    _t["second"] = t["second"]
  end

  return _t
end

local function _get_option(t)
  local _t = {}

  if t["system"] ~= nil then
    assert(t["system"] == "12-clock" or t["system"] == "24-clock")
    _t["system"] = t["system"]
  end

  if _t["system"] == "12-clock" then
    assert(t["period"] == "am" or t["period"] == "pm")
    _t["period"] = t["period"]
  else
    _t["period"] = nil
  end

  return _t
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

--- Create a new Time object.
-- @param table A table present Time.  Available parameters includes:
--
-- * day: integer, it could be either positive or negative.
-- * hour: 0 <= hour < 24, integer
-- * minute: 0 <= minute < 60, integer
-- * second: 0 <= second < 60, integer
--
-- @param option Optional.  A table present options. Available options includes:
--
-- * system: either "12-clock" or "24-clock".  Default to 24-clock.
-- * period: either "am" or "pm"  Mandatory when on "12-clock" system.
--
-- @return A Time object.
function Time:new(table, option)
  local _table = _get_time(table)
  local _option
  if option == nil then
    _option = _get_option({})
  else
    _option = _get_option(option)
  end

  self = {}
  setmetatable(self, Time)
  self._day = _table["day"]
  assert(self._day % 1 == 0)

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

  -- Remember the clock system set by user
  self.system = _option["system"]
  self.period = _option["period"]

  return self
end

--- Get the day of the time object.
-- @return days (number)
function Time:day()
  return self._day
end

--- Get the hour of the time object (in 24-clock system).
-- @return hours (number)
function Time:hour()
  return self._hour
end

--- Get the minute of the time object.
-- @return minutes (number)
function Time:minute()
  return self._minute
end

--- Get the second of the time object.
-- @return second (number)
function Time:second()
  return self._second
end

--- Convert time object to seconds.
-- You may use the return value with Lua standard date/time library.
-- @return second (number)
function Time:to_second()
  return 86400 * self._day + 3600 * self._hour + 60 * self._minute + self._second
end

return Time
