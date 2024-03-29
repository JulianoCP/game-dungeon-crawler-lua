--[[
    All Itens used in the game.
    Gets and Sets for the itens.
]]

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
                    damage = 7,
                    levelEquip = 2,
                    critical = 1,
                    accuracy = 3,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/itens/sword_1.png")
                },

                poisonSword = {
                    name = "Sword of Poison",
                    desc = "espada de venenu",
                    damage = 5,
                    levelEquip = 1,
                    critical = 1,
                    accuracy = 7,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/itens/sword_2.png")
                },

                ironSword = {
                    name = "Sword of Iron",
                    desc = "Espada De ferro ferrado",
                    damage = 7,
                    levelEquip = 1,
                    critical = 1,
                    accuracy = 5,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/itens/sword_3.png")
                },

                corruptionSword = {
                    name = "Blade of Corruption",
                    desc = "A lamina da Corrupção",
                    damage = 9,
                    levelEquip = 2,
                    critical = 1,
                    accuracy = 5,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/itens/sword_4.png")
                },

                soulSword = {
                    name = "Sword of Soul",
                    desc = "Corta até a alma",
                    damage = 6,
                    levelEquip = 1,
                    critical = 1,
                    accuracy = 6,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/itens/sword_5.png")
                },

                daggerSword = {
                    name = "Dagger",
                    desc = "Adaguinha",
                    damage = 3,
                    levelEquip = 1,
                    critical = 1,
                    accuracy = 10,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/itens/sword_6.png")
                },

                magicSword = {
                    name = "Sword Of Magic",
                    desc = "Não é magia é tecnologia",
                    damage = 10,
                    levelEquip = 2,
                    critical = 1,
                    accuracy = 10,
                    type = "sword",
                    sprite = love.graphics.newImage("assets/itens/sword_7.png")
                },
            },

            armor = {

                leatherArmor = {
                    name = "Leather Armor",
                    desc = "armadura de cabra",
                    defese = 3,
                    levelEquip = 1,
                    dexterity = 2,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/itens/armor_1.png")
                },

                dragonArmor = {
                    name = "Dragon Armor",
                    desc = "Escama do dragão da sua mae",
                    defese = 7,
                    levelEquip = 1,
                    dexterity = -1,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/itens/armor_2.png")
                },
                
                natureArmor = {
                    name = "Nature Armor",
                    desc = "Poder Natural",
                    defese = 4,
                    levelEquip = 1,
                    dexterity = 2,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/itens/armor_3.png")
                },

                poisonArmor = {
                    name = "Poison Armor",
                    desc = "Poison da cobra da sua mae",
                    defese = 2,
                    levelEquip = 1,
                    dexterity = 5,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/itens/armor_4.png")
                },

                iceArmor = {
                    name = "Ice Armor",
                    desc = "Gelinho",
                    defese = 7,
                    levelEquip = 2,
                    dexterity = 1,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/itens/armor_5.png")
                },

                scaleArmor = {
                    name = "Scale Armor",
                    desc = "O Matador",
                    defese = 2,
                    levelEquip = 1,
                    dexterity = 8,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/itens/armor_6.png")
                },

                abyssalArmor = {
                    name = "Abyssal Armor",
                    desc = "Poder Infinito",
                    defese = 1,
                    levelEquip = 1,
                    dexterity = 10,
                    type = "armor",
                    sprite = love.graphics.newImage("assets/itens/armor_7.png")
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
    local name = {'fireSword','poisonSword', 'ironSword', 'corruptionSword', 'soulSword', 'daggerSword', 'magicSword' }
    local numSort = 0
    local isLevel = true
    while isLevel do
        numSort = math.random(table.getn(name))
        if (self.sword[name[numSort]].levelEquip <= level) then isLevel = false end
    end
    return self.sword[name[numSort]]
end

function Itens:getRandomArmor(level)
    math.randomseed(os.clock())
    local name = {'leatherArmor','dragonArmor','abyssalArmor','scaleArmor','iceArmor','poisonArmor','natureArmor'}

    local numSort = 0
    local isLevel = true
    while isLevel do
        numSort = math.random(table.getn(name))
        if (self.armor[name[numSort]].levelEquip <= level) then isLevel = false end
    end
    return self.armor[name[numSort]]
end

return Itens