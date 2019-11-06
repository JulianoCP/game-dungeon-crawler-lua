local Player = {}
Player.__index = Player

function Player:new(Px, Py, currentSprite)
  
    local player = {

        props = {
            Px = Px,
            Py = Py,
            Sprite = {
                spriteUp = love.graphics.newImage("assets/player/player_up.png"),
                spriteDown = love.graphics.newImage("assets/player/player_down.png") ,
                spriteRight = love.graphics.newImage("assets/player/player_right.png"),
                spriteLeft = love.graphics.newImage("assets/player/player_left.png")
            },
            currentSprite = currentSprite
          },

        status = {
            damage = 10,
            defese = 10,
            dexterity = 10,
            accuracy = 10,
            critical = 10,
            life = 100,
            exp = 0,
            level = 0
        },

        invetory = {
            potion = 3
        },

        equip = {
            sword = nil,
            armor = nil,
        }
      }

      setmetatable(player, Player)

    return player

end


function Player:getPx()
    return self.props["Px"]
end

function Player:getPy()
    return self.props["Py"]
end

function Player:setPy(px)
    self.props["Px"] = px;
end

function Player:setPx(py)
    self.props["Py"] = py;
end

function Player:getSprite()
    return self.props.Sprite[self.props.currentSprite]
end


function Player:setSprite(sprite)
    self.props["currentSprite"] = sprite
end


return Player