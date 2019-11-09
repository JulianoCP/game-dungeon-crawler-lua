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

function Map:isColliderInside(x,y)
  return self.props["mapData"][y][x]
end

function Map:isCollider(x,y,name)
  if x < 2 or y < 2 then return false
  elseif self.props["mapData"][y - 1][x] == name then return true 
  elseif self.props["mapData"][y + 1][x] == name then return true 
  elseif self.props["mapData"][y][x - 1] == name then return true 
  elseif self.props["mapData"][y][x + 1] == name then return true 
  else return false end
end

return Map