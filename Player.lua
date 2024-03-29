--[[
    Structure made for game player.
]]

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
            damage = 1,
            defese = 1,
            dexterity = 1,
            accuracy = 2,
            maxLife = 100,
            critical = 1,
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

function Player:setXP(value)
    self.status["exp"] = self.status["exp"] + value

    if self.status["exp"] >= 100 then
        self.status["exp"] = 0
        self.status["level"] = self.status["level"] + 1
        self.status["damage"] = self.status["damage"] + 2
        self.status["defese"] = self.status["defese"] + 2
        self.status["dexterity"] = self.status["dexterity"] + 2
        self.status["accuracy"] = self.status["accuracy"] + 2
        self.status["maxLife"] = self.status["maxLife"] + 10
        self.status["life"] = self.status["maxLife"]
        return true
    end
    return false
end

function Player:getXP()
    return self.status["exp"]
end

function Player:setEquipSword(item)
    self.equip["sword"] = item
end

function Player:setEquipArmor(item)
    self.equip["armor"] = item
end

function Player:getDefeseArmor()
    if self.equip["armor"] == nil then return 0 end
    return self.equip["armor"].defese
end

function Player:getDexterityArmor()
    if self.equip["armor"] == nil then return 0 end
    return self.equip["armor"].dexterity
end

function Player:getCriticalSword()
    if self.equip["sword"] == nil then return 0 end
    return self.equip["sword"].critical
end

function Player:getAccuracySword()
    if self.equip["sword"] == nil then return 0 end
    return self.equip["sword"].accuracy
end

function Player:getDamageSword()
    if self.equip["sword"] == nil then return 0 end
    return self.equip["sword"].damage
end

function Player:getEquipSwordName()
    if self.equip["sword"] == nil then return "Not Equiped" end
    return self.equip["sword"].name
end

function Player:getEquipArmorName()
    if self.equip["armor"] == nil then return "Not Equiped" end
    return self.equip["armor"].name
end

function Player:getEquipArmorSprite()
    if self.equip["armor"] == nil then return nil end
    return self.equip["armor"].sprite
end


function Player:getEquipSwordSprite()
    if self.equip["sword"] == nil then return nil end
    return self.equip["sword"].sprite
end

function Player:setInventoryPotion(potion)
    if not(self.invetory["potion"] + potion > 6 or self.invetory["potion"] + potion < 0) then
        self.invetory["potion"] = self.invetory["potion"] + potion
    end
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

function Player:getMaxLife()
    return self.status["maxLife"]
end

function Player:getLevel()
    return self.status["level"] 
end

function Player:setLevel(value)
    self.status["level"] = value
end

return Player