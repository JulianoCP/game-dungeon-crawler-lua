local Map = {}
Map.__index = Map

function Map:new(mapName, mapData, mapLevel)
  
    local map = {

        props = {
            mapName = mapName,
            mapData = mapData,
            mapLevel = mapLevel
          }
      }
    setmetatable(map, Map)
    return map
    
  end

function Map:getMap()
    return self.props["mapData"]
end

function Map:isCollider(x,y)
  return self.props["mapData"][y][x]
end

return Map