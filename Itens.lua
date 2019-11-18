local Itens = {}
Itens.__index = Itens

function Itens:new()
  
    local itens = {

            potions = {

                potionHeal = {
                    name = "Potion of Healing",
                    desc = "potion de curita",
                    type = "potion",
                    levelEquip = 0,
                }
                
            },

            sword = {
                
                fireSword = {
                    name = "Sword of Fire",
                    desc = "espada de fuego",
                    damage = 20,
                    levelEquip = 2,
                    critical = 1,
                    accuracy = 1,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/gui/sword_1.png")
                },

                poisonSword = {
                    name = "Sword of Poison",
                    desc = "espada de venenu",
                    damage = 10,
                    levelEquip = 1,
                    critical = 1,
                    accuracy = 7,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/gui/sword_2.png")
                }
            },

            armor = {

                leatherArmor = {
                    name = "Leather Armor",
                    desc = "armadura de cabra",
                    defese = 3,
                    levelEquip = 1,
                    dexterity = 1,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/gui/armor_1.png")
                },

                dragonArmor = {
                    name = "Dragon Armor",
                    desc = "Escama do dragão da sua mae",
                    defese = 10,
                    levelEquip = 2,
                    dexterity = -5,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/gui/armor_2.png")
                }
            }
    }
    setmetatable(itens, Itens)
    return itens

end

function Itens:getNameItem()
    return self.sword[name]
end

function Itens:getPotion()
    return self.potions["potionHeal"]
end

function Itens:getRandomSword(level)
    math.randomseed(os.clock())
    local name = {'fireSword','poisonSword'}
    local numSort = 0
    local isLevel = true
    while isLevel do
        for i = 0 , 10 do numSort = math.random(2) end
        if (self.sword[name[numSort]].levelEquip == level) then isLevel = false end
    end
    return self.sword[name[numSort]]
end

function Itens:getRandomArmor(level)
    math.randomseed(os.clock())
    local name = {'leatherArmor','dragonArmor'}
    local numSort = 0
    local isLevel = true
    while isLevel do
        for i = 0 , 10 do numSort = math.random(2) end
        if (self.armor[name[numSort]].levelEquip == level) then isLevel = false end
    end
    return self.armor[name[numSort]]
end

return Itens