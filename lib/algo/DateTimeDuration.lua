--- algo.DateTimeDuration class.
-- A class presents datetime duration.
-- @classmod DateTimeDuration
local DateTimeDuration = {}
package.loaded['DateTimeDuration'] = DateTimeDuration

DateTimeDuration.__index = DateTimeDuration

local function _get_datetime(table)
  local t = {}
  
  if table["year"] == nil then
    t["year"] = 0
  else
    assert(table["year"] % 1 == 0)
    t["year"] = table["year"]
  end
  
  if table["month"] == nil then
    t["month"] = 0
  else
    assert(table["month"] % 1 == 0)
    t["month"] = table["month"]
  end
  
  if table["day"] == nil then
    t["day"] = 0
  else
    assert(table["day"] % 1 == 0)
    t["day"] = table["day"]
  end
  
  if table["hour"] == nil then
    t["hour"] = 0
  else
    assert(table["hour"] % 1 == 0)
    t["hour"] = table["hour"]
  end
  
  if table["minute"] == nil then
    t["minute"] = 0
  else
    assert(table["minute"] % 1 == 0)
    t["minute"] = table["minute"]
  end
  
  if table["second"] == nil then
    t["second"] = 0
  else
    assert(table["second"] % 1 == 0)
    t["second"] = table["second"]
  end
  
  return t
end

function DateTimeDuration:new(table)
  local _table
  if table == nil then
    _table = _get_datetime({})
  else
    _table = _get_datetime(table)
  end
  
  self = {}
  setmetatable(self, DateTimeDuration)
  self._year = _table["year"]
  self._month = _table["month"]
  self._day = _table["day"]
  self._hour = _table["hour"]
  self._minute = _table["minute"]
  self._second = _table["second"]
  
  return self
end

function DateTimeDuration:year()
  return self._year
end

function DateTimeDuration:month()
  return self._month
end

function DateTimeDuration:day()
  return self._day
end

function DateTimeDuration:hour()
  return self._hour
end

function DateTimeDuration:minute()
  return self._minute
end

function DateTimeDuration:second()
  return self._second
end

return DateTimeDuration