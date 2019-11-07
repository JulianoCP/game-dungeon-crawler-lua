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
                    accuracy = 1
                },

                poisonSword = {
                    name = "Sword of Poison",
                    desc = "espada de venenu",
                    damage = 10,
                    critical = 1,
                    accuracy = 10
                }
            },

            armor = {

                leatherArmor = {
                    name = "Leather Armor",
                    desc = "armadura de cabra",
                    defense = 10,
                    dextery = 1,
                    life = 20,
                },

                dragonArmor = {
                    name = "Dragon Armor",
                    desc = "escama do dragão da sua mae",
                    defense = 50,
                    dextery = -5,
                    life = 50,
                }
            }
    }
    setmetatable(itens, Itens)
    return itens

end

function Itens:getSword(name)
    return self.sword[name]
end

function Itens:getRandomSword()
    math.randomseed(os.time())
    local name = {'fireSword','poisonSword'}
    return self.sword[name[math.random(2)]]
end 

return Itens