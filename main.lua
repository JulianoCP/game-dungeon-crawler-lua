-- Require
Map = require 'Map'
Player = require 'Player'
Itens = require 'Itens'
blocks = require 'Blocks'
gui = require 'Gui'
arrayMaps = require 'MapLoad' 
FogWar = require 'Fog'

-- Controll
state = "move"
mapControl = nil
itemChest = nil
pressRunAway = false
numberTryToRun = 0
potionHeal = 20

function love.load()
    love.keyboard.setKeyRepeat(true)

    local maps = nil
    fog = FogWar
    love.graphics.setFont(love.graphics.newFont("assets/fonts/cc.otf", 14))
    
    -- Seta o Primeiro Mapa
    mapControl = arrayMaps[1]
    love.window.setTitle(mapControl:getNameMap())

    playerControl = Player:new(2,2,"spriteRight")

end

function drawPlayer()

    local width = playerControl:getSprite():getDimensions()
    love.graphics.setColor(1, 1, 1, 100) -- Cor Original
    love.graphics.draw(playerControl:getSprite(), (width*playerControl:getPy())-6, (width*playerControl:getPx())-6 )
    
end

function drawMap(map)
    love.graphics.setColor(1, 1, 1, 100) -- Cor Original
    local width = blocks["x"]:getDimensions()

    -- Desenha Mapa
    for i = 1, table.getn(map) do
        for j = 1 , table.getn(map[1]) do
            local code = map[i][j]
            love.graphics.draw(blocks["f"], (width*j)-6, (width*i)-6)
            love.graphics.draw(blocks[code], (width*j)-6, (width*i)-6)
        end
    end
    
    -- Fog 
    for i = 1 , table.getn(fog) do
        for j = 1 , table.getn(fog) do
            if fog[i][j] == "k" then
                fog[i][j] = "j"
            end
        end
    end
    
    --Fog Nivel 1
    for i = playerControl:getPx() - 1 , playerControl:getPx() + 1 do
        for j = playerControl:getPy() - 1 , playerControl:getPy() + 1 do
            if i <= 1 then i = 1 end
            if j <= 1 then j = 1 end
            fog[i][j] = "k"
        end
    end

    -- BlackOut
    for i = 1, table.getn(fog) do
        for j = 1 , table.getn(fog[1]) do
            if fog[i][j] == 'w' then
                love.graphics.setColor(0, 0, 0, 100)
                love.graphics.rectangle("fill", (width*j)-6, (width*i)-6, width, width )
            elseif fog[i][j] == 'j' then
                love.graphics.setColor(0, 0, 0, 0.5)
                love.graphics.rectangle("fill", (width*j)-6, (width*i)-6, width, width )
            end
        end
    end
end

function drawText(text, x, y, align)

    local myY = y
    local myX = x
    local padding = 300

    if align == nil then align = "left" end

    if myY == 1 then myY = 430
        elseif myY == 2 then myY = 460
        elseif myY == 3 then myY = 485
        elseif myY == 4 then myY = 510
        elseif myY == 5 then myY = 535
        elseif myY == 6 then myY = 560
        elseif myY == 7 then myY = 585
        elseif myY == 8 then myY = 610
        elseif myY == 9 then myY = 635
    end

    if myX == 1 then myX = 20
        elseif myX == 2 then myX = 300 padding = 240
        elseif myX == 3 then myX = 580 padding = 220
    end

    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.printf(text, myX, myY, padding, align)

end

function  drawStat(text, x, y)
    
    local myY = y
    local myX = x
    local padding = 300
    
    if myX == 1 then myX = 238 end
    if myX == 2 then myX = 304 end
    if myX == 3 then myX = 370 end

    if myY == 1 then myY = 460
        elseif myY == 2 then myY = 485
        elseif myY == 3 then myY = 510
        elseif myY == 4 then myY = 535
        elseif myY == 5 then myY = 560
        elseif myY == 6 then myY = 585
    end

    love.graphics.setColor(0, 0, 0, 100)
    if text < 0 then love.graphics.setColor(1, 0, 0, 100) end
    love.graphics.printf(text, myX, myY, padding, "center")

end

function drawMenu()
    -- 9 Linhas -- 3 Colunas
    if state == "move" then

        drawText("                COMANDO:", 1, 1)
        drawText("[D] ou ( → ) - Mover para Direita" , 1, 2)
        drawText("[A] ou ( ← ) - Mover para Esquerda" , 1, 3)
        drawText("[W] ou  ( ↑ ) - Mover para Cima" , 1, 4)
        drawText("[S] ou  ( ↓ ) - Mover para Baixo" , 1, 5)
        drawText("[F] - Para usar Potion" , 1, 6)

    elseif state == "chest" then

        drawText("                COMANDO:", 1, 1)
        drawText("ITEM ENCONTRADO" , 1, 2)

        if itemChest.type == "sword" then drawText("["..itemChest.name .."]\n[DMG : "..itemChest.damage.."] [CRIT : "..itemChest.critical.."] [ACC : "..itemChest.accuracy.."]" , 1, 3) end
        if itemChest.type == "armor" then drawText("["..itemChest.name.."]\n[DEF : "..itemChest.defese.."] [DEX : "..itemChest.dexterity.."] [VIT : "..itemChest.life.."]" , 1, 3) end 
        if itemChest.type == "potion" then drawText("[POTION] + [ 1 ]" , 1, 3) end 
        drawText("SEU ITEM" , 1, 5)

        if itemChest.type == "sword" and not(playerControl:getEquipSwordName() == "No Equiped") then drawText("["..playerControl:getEquipSwordName().."]\n[DMG : "..playerControl:getDamageSword().."] [CRIT : "..playerControl:getCriticalSword().."] [ACC : "..playerControl:getAccuracySword().."]" , 1, 6) elseif playerControl:getEquipSwordName() == "No Equiped" and itemChest.type == "sword" then drawText("Você não tem arma equipada!",1,6) end
        if itemChest.type == "armor" and not(playerControl:getEquipArmorName() == "No Equiped") then drawText("["..playerControl:getEquipArmorName().."]\n[DEF : "..playerControl:getDefeseArmor().."] [DEX : "..playerControl:getDexterityArmor().."] [VIT : "..playerControl:getLifeArmor().."]" , 1, 6) elseif playerControl:getEquipArmorName() == "No Equiped" and itemChest.type == "armor" then drawText("Você não tem armadura equipada!",1,6) end
        if itemChest.type == "potion" then drawText("[POTION] = ".."[ "..playerControl:getInventoryPotion().." ]" , 1, 6) end

        if itemChest.type == "armor" or itemChest.type == "sword" then
            drawText("[E]   - Você Aceita a Troca" , 1, 8)
            drawText("[Q]   - Você Rejeita a Troca" , 1, 9)
        elseif itemChest.type == "potion" then
            drawText("[E]   - Você Pega o Potion" , 1, 8)
            drawText("[Q]   - Você Rejeita o Potion" , 1, 9)
        end

    elseif state == "battle" then
        drawText("BATTLE:", 1, 1, "center")
        if pressRunAway == false then
            drawText("[E] ou (←)   - Start the battle" , 1, 3)
            drawText("[Q] ou (→)   - Try to run away" , 1, 4)    
        end

        if pressRunAway == true then
            if numberTryToRun >= 128 then 
                drawText("Can you run away" , 1, 2) 
                drawText("[V] ou (→)   - To run away" , 1, 4)
                elseif numberTryToRun < 128 and numberTryToRun > 0 then
                    drawText("Could not run away" , 1, 2) 
                    drawText("[C] ou (→)   - Start the battle" , 1, 4)
            end
        end
            
    elseif state == "winner" then
        --A FAZER
    end

    -- Desenha as cores nos Stats
    love.graphics.setColor(1, 0 , 0, 0.2)
    love.graphics.rectangle("fill", 355, 430, 65, 180 )

    love.graphics.setColor(0, 0, 1, 0.2)
    love.graphics.rectangle("fill", 420, 430, 65, 180 )

    love.graphics.setColor(0, 1, 0, 0.2)
    love.graphics.rectangle("fill", 485, 430, 60, 180 )

    for i = 1, 6 do
        love.graphics.setColor(1,1 , 1, 0.4)
        love.graphics.rectangle("fill", 295, 435+(25*i), 245, 18 )
    end

    drawText("                    SWORD      ARMOR      BASE" , 2, 1)
    drawText("STR: "..playerControl:getDamage()+playerControl:getDamageSword(), 2, 2)
    drawStat(playerControl:getDamageSword(), 1,1)
    drawStat(playerControl:getDamage(), 3,1)
    
    drawText("DEF: "..playerControl:getDefese()+playerControl:getDefeseArmor(), 2, 3)
    drawStat(playerControl:getDefeseArmor(), 2,2)
    drawStat(playerControl:getDefese(), 3,2)
    
    drawText("ACC: "..playerControl:getAccuracy()+playerControl:getAccuracySword(), 2, 4)
    drawStat(playerControl:getAccuracySword(), 1,3)
    drawStat(playerControl:getAccuracy(), 3,3)
    
    drawText("DEX: "..playerControl:getDexterity()+playerControl:getDexterityArmor(), 2, 5)
    drawStat(playerControl:getDexterityArmor(), 2,4)
    drawStat(playerControl:getDexterity(), 3,4)

    drawText("CRT: "..playerControl:getCritical()+playerControl:getCriticalSword(), 2, 6)
    drawStat(playerControl:getCriticalSword(), 1,5)
    drawStat(playerControl:getCritical(), 3,5)

    drawText("VIT: "..playerControl:getLife()+playerControl:getLifeArmor(), 2, 7)
    drawStat(playerControl:getLifeArmor(), 2,6)
    drawStat(playerControl:getLife(), 3,6)
    
    
    
    drawText("\nVida: "..playerControl:getLife()..
    "\nLevel: "..playerControl:getLevel() , 3, 1)
    drawText("XP: "..playerControl:getExp() , 3, 3)
    -- Controle do SET na GUI
    
    drawText("INVENTARIO:" , 3, 4, "center")
    
    love.graphics.setColor(1, 1, 1, 100)
    
    if (playerControl:getEquipArmorSprite() == nil) then
        love.graphics.draw(gui["noArmor"], 580, 540 )
        
    else
        love.graphics.draw(gui["noArmor"], 580, 540 )
        love.graphics.draw(playerControl:getEquipArmorSprite(), 580, 540 )
        
    end
    
    if (playerControl:getEquipSwordSprite() == nil) then
        love.graphics.draw(gui["noSword"], 580, 580 )
        
    else
        love.graphics.draw(gui["noSword"], 580, 580 )
        love.graphics.draw(playerControl:getEquipSwordSprite(), 580, 580 )
        
    end
    drawText("\n\n"..playerControl:getEquipArmorName() , 3, 4,'center')
    drawText(playerControl:getEquipSwordName() , 3, 7,'center')
    
    love.graphics.setColor(1, 1, 1, 100)
    
    local potionQtd = 0
    for i = 1, playerControl:getInventoryPotion() do
        love.graphics.draw(gui["potion"], 580+potionQtd, 625 )
        potionQtd = potionQtd + 35
    end
    
    --[[
        ]]
        
        
    end

function love.draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(gui["dungeon"], 420, 10 )
    love.graphics.draw(gui["interface"], 0, 0 )

    drawMap(mapControl:getMap())
    drawPlayer()
    drawScene()
    drawMenu()

end

function drawScene()
    if state == "chest" then
        love.graphics.draw(gui["chest"], 420,10 )
    end
end

function clearFog()
    for i = 1 , table.getn(fog) do
        for j = 1 , table.getn(fog[1]) do
            fog[i][j] = "w"
        end
    end
end

function love.keypressed(key, scancode)

    local x = playerControl:getPy()
    local y = playerControl:getPx()

    if key == 'f1' then playerControl:setInventoryPotion(1) end
    if key == 'f2' then playerControl:setLife(playerControl:getLife() - 20) end

    if key == 'f' then
        if playerControl:getInventoryPotion() > 0 then 
            playerControl:setInventoryPotion(-1)
            if ( playerControl:getLife() + potionHeal ) > playerControl:getMaxLife() then playerControl:setLife(playerControl:getMaxLife()) 
            elseif playerControl:getLife() <  playerControl:getMaxLife() then playerControl:setLife( playerControl:getLife() + potionHeal ) end
        end
    end 

    if state == "move" then

        if key == "right" or key == "d" then x = x+1  playerControl:setSprite("spriteRight") end
        if key == "left" or key == "a" then x = x-1 playerControl:setSprite("spriteLeft") end
        if key == "up" or key == "w" then y = y - 1 playerControl:setSprite("spriteUp")  end
        if key == "down" or key == "s" then  y = y + 1 playerControl:setSprite("spriteDown") end

        if  not (mapControl:isColliderInside(x,y) == 'x' or mapControl:isColliderInside(x,y) == 'x1') then
            playerControl:setPx(x)
            playerControl:setPy(y)
        end

        --Colisao com os Monstros
        if mapControl:isCollider(x,y,'m1') == true then state = "battle" end

        if mapControl:isColliderInside(x,y) == 'c' then
            math.randomseed(os.time())
            local a = Itens:new()
            local numSort = 0
            for i = 0 , 10 do numSort = math.random(3) end
            if numSort == 1 then itemChest = a:getRandomSword() elseif numSort == 1 then itemChest = a:getRandomArmor() else itemChest = a:getPotion() end
            mapControl:getMap()[y][x] = 'f'
            state = "chest"
        end

        if mapControl:isColliderInside(x,y) == 's' then
            mapControl = arrayMaps[mapControl:getMapLevel()+1]
            love.window.setTitle(mapControl:getNameMap())
            playerControl:setPx(2)
            playerControl:setPy(2)
            clearFog()
        end

    end

    if state == "chest" then
        if key == "e" then if itemChest.type == "sword" then playerControl:setEquipSword(itemChest) elseif itemChest.type == "armor" then playerControl:setEquipArmor(itemChest) else playerControl:setInventoryPotion(1) end state = "move" end
        if key == "q" then state = "move" end
    end

    if state == "battle" then
        if key == "e" then state = "move" end
        if key == "q" then
            pressRunAway = true 
            math.randomseed(os.time())
            for i = 0 , 10 do numberTryToRun = math.random(255) end 
        end
        if key == "v" and pressRunAway == true and numberTryToRun >= 128 then pressRunAway = false state = "move"  numberTryToRun = 0 end
        if key == "c" and pressRunAway == true and numberTryToRun < 128 then pressRunAway = false state = "move"  numberTryToRun = 0 end
    end

end
