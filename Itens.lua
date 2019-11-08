local Itens = {}
Itens.__index = Itens

function Itens:new()
  
    local itens = {

            sword = {
                
                fireSword = {
                    name = "Sword of Fire",
                    desc = "espada de fuego",
                    damage = 20,
                    critical = 1,
                    accuracy = 1,
                    type = "sword",
                },

                poisonSword = {
                    name = "Sword of Poison",
                    desc = "espada de venenu",
                    damage = 10,
                    critical = 1,
                    accuracy = 10,
                    type = "sword",
                }
            },

            armor = {

                leatherArmor = {
                    name = "Leather Armor",
                    desc = "armadura de cabra",
                    defense = 10,
                    dexterity = 1,
                    life = 20,
                    type = "armor",
                },

                dragonArmor = {
                    name = "Dragon Armor",
                    desc = "escama do dragão da sua mae",
                    defese = 50,
                    dexterity = -5,
                    life = 50,
                    type = "armor",
                }
            }
    }
    setmetatable(itens, Itens)
    return itens

end

function Itens:getNameItem()
    return self.sword[name]
end

function Itens:getRandomSword()
    math.randomseed(os.time())
    local name = {'fireSword','poisonSword'}
    return self.sword[name[math.random(2)]]
end

function Itens:getRandomArmor()
    math.randomseed(os.time())
    local name = {'leatherArmor','dragonArmor'}
    return self.armor[name[math.random(2)]]
end

return Itens