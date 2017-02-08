--- `algo.Time` class.
-- A Time class with no knowledge to date.  All time beyond 24 hours will be
-- converted to days.
-- @classmod Time
local Time = {}
package.loaded['algo.Time'] = Time

Time.__index = Time

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
-- * day
-- * hour
-- * minute
-- * second
--
-- @param option Optional.  A table present options. Available options includes:
--
-- * system: either "12-clock" or "24-clock".  Default to 24-clock.
-- * period: either "a.m." or "p.m."  Mandatory when on "12-clock" system.
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

  -- Internally, we use 24-clock to present hour.
  if _option["system"] == "12-clock" then
    self._hour = _convert_hour(_table["hour"], _option["period"])
  else
    self._hour = _table["hour"]
  end

  self._minute = _table["minute"]
  self._second = _table["second"]

  -- Initially, all Time objects are positive.
  self.sign = "+"

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

return Time
