--[[
    Structure made for game maps.
]]

local Map = {}
Map.__index = Map

function Map:new(mapName, mapData, mapLevel)
  
    local map = {

        props = {
            mapName = mapName,
            mapData = mapData,
            mapLevel = mapLevel,
          }
      }
    setmetatable(map, Map)
    return map
    
  end

function Map:getMapLevel()
  return self.props["mapLevel"]
end

function Map:getNameMap()
  return self.props["mapName"]
end

function Map:getMap()
  return self.props["mapData"]
end

-- Return which tile the player is on.
function Map:isColliderInside(x,y)
  return self.props["mapData"][y][x]
end

-- Returns which position the player collided with monster
function Map:getMonsterTile(x,y,name)

  if self.props["mapData"][y][x] == name then return y , x ,name
  else return false end
  
end

return Map