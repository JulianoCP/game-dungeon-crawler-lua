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

function Player:setEquipSword(item)
    self.equip["sword"] = item
end

function Player:getDamageSword()
    if self.equip["sword"] == nil then return 0 end
    return self.equip["sword"].damage
end

function Player:getEquipSwordName()
    if self.equip["sword"] == nil then return "No Equiped" end
    return self.equip["sword"].name
end

function Player:setInventoryPotion(potion)
    self.invetory["potion"] = self.invetory["potion"] + potion
end

function Player:getInventoryPotion()
    return self.invetory["potion"]
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

-- Get's and Set's Sprite
function Player:getSprite()
    return self.props.Sprite[self.props.currentSprite]
end

function Player:setSprite(sprite)
    self.props["currentSprite"] = sprite
end

--- Get's and Set's Status
function Player:getDamage()
    return self.status["damage"]
end

function Player:setDamage(value)
    self.status["damage"] = value
end

function Player:getDefese()
    return self.status["defese"] 
end

function Player:setDefese(value)
    self.status["defese"] = value
end

function Player:getDexterity()
    return self.status["dexterity"] 
end

function Player:setDexterity(value)
    self.status["dexterity"] = value
end

function Player:getAccuracy()
    return self.status["accuracy"] 
end

function Player:setAccuracy(value)
    self.status["accuracy"] = value
end

function Player:getCritical()
    return self.status["critical"] 
end

function Player:setCritical(value)
    self.status["critical"] = value
end

function Player:getLife()
    return self.status["life"] 
end

function Player:setLife(value)
    self.status["life"] = value
end

function Player:getExp()
    return self.status["exp"] 
end

function Player:setExp(value)
    self.status["exp"] = value
end

function Player:getLevel()
    return self.status["level"] 
end

function Player:setLevel(value)
    self.status["level"] = value
end

return Player