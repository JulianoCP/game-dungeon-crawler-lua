Map = require 'Map'
Player = require 'Player'
Itens = require 'Itens'
state = "move"
FogWar = require 'Fog'

-- Maps
Mix = require("/maps/Mix")
Dungeon = require("/maps/Dungeon")
Fosso = require("/maps/Fosso")
Siberia = require("/maps/Siberia")

mapControl = nil
itemChest = nil
arrayMaps = {}

function love.load()
    love.keyboard.setKeyRepeat(true)

    local maps = nil
    fog = FogWar
    love.graphics.setFont(love.graphics.newFont("assets/fonts/cc.otf", 14))
    mapControl = Map:new("Labirinto - Lamento Sombrio" , Dungeon , 1)
    love.window.setTitle(mapControl:getNameMap())
    table.insert( arrayMaps, mapControl )
    
    -- Inserindo Outros Mapas
    maps = Map:new("Labirinto - Fosso das Lamentações" , Fosso , 2)
    table.insert( arrayMaps, maps )
    maps = Map:new("Labirinto - Perdidos no Siberia" , Siberia , 3)
    table.insert( arrayMaps, maps )
    maps = Map:new("Labirinto - MIX" , Mix , 4)
    table.insert( arrayMaps, maps )
    
    playerControl = Player:new(2,2,"spriteRight")
    
    blocks = {
        x = love.graphics.newImage("assets/tiles/wall.png"), -- Parede
        x1 = love.graphics.newImage("assets/tiles/wall_3.png"), -- Parede
        f = love.graphics.newImage("assets/tiles/floor_1.png"), -- Chão Tipo 1
        f1 = love.graphics.newImage("assets/tiles/floor_2.png"), -- Chão Tipo 2
        f2 = love.graphics.newImage("assets/tiles/floor_3.png"), -- Chão Tipo 3
        f3 = love.graphics.newImage("assets/tiles/floor_4.png"), -- Chão Tipo 4
        f4 = love.graphics.newImage("assets/tiles/floor.png"), -- Chão Tipo 5
        f5 = love.graphics.newImage("assets/tiles/floor_5.png"), -- Chão Tipo 6
        c = love.graphics.newImage("assets/obj/chest_1.png"), -- Bau Tipo 1
        c1 = love.graphics.newImage("assets/obj/chest.png"), -- Bau Tipo 2
        s = love.graphics.newImage("assets/tiles/stair_1.png"), -- Escada
        m = love.graphics.newImage("assets/monsters/monster_1.png"), -- Monstro Tipo 1
        m1 = love.graphics.newImage("assets/monsters/monster_2.png"), -- Monstro Tipo 2
        m2 = love.graphics.newImage("assets/monsters/monster_3.png"), -- Monstro Tipo 3
        m3 = love.graphics.newImage("assets/monsters/monster_4.png"), -- Monstro Tipo 4
    }

    gui ={
        interface = love.graphics.newImage("assets/gui/gui_interface.png"),
        chest = love.graphics.newImage("assets/gui/dungeonChest.png"),
        dungeon = love.graphics.newImage("assets/gui/dungeonWalking.png"),
        frame = love.graphics.newImage("assets/gui/interface_scene.png"),
        noArmor = love.graphics.newImage("assets/gui/NoArmor.png"),
        noSword = love.graphics.newImage("assets/gui/NoSword.png"),
    }

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

    if myY == 1 then
        myY = 430
    elseif myY == 2 then
        myY = 460
    elseif myY == 3 then
        myY = 485
    elseif myY == 4 then
        myY = 510
    elseif myY == 5 then
        myY = 535
    elseif myY == 6 then
        myY = 560
    elseif myY == 7 then
        myY = 585
    elseif myY == 8 then
        myY = 610
    elseif myY == 9 then
        myY = 635
    end

    if myX == 1 then
        myX = 20
    elseif myX == 2 then
        myX = 350
        padding = 190
    elseif myX == 3 then
        myX = 580
        padding = 220
    end

    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.printf(text, myX, myY, padding, align)
end

function drawMenu()
    -- 9 Linhas -- 3 Colunas
    if state == "move" then
        drawText("COMANDO:", 1, 1, "center")
        drawText("[D] ou (→)   - Mover para Direita" , 1, 2)
        drawText("[A] ou (←)   - Mover para Esquerda" , 1, 3)
        drawText("[W] ou  (  ↑  )      - Mover para Cima" , 1, 4)
        drawText("[S] ou  (  ↓  )      - Mover para Baixo" , 1, 5)
    elseif state == "chest" then
        drawText("COMANDO:", 1, 1, "center")
        drawText("ITEM ENCONTRADO" , 1, 2)
        if itemChest.type == "sword" then drawText("["..itemChest.name .."]\n[DMG : "..itemChest.damage.."] [CRIT : "..itemChest.critical.."] [ACC : "..itemChest.accuracy.."]" , 1, 3) end
        if itemChest.type == "armor" then drawText("["..itemChest.name.."]\n[DEF : "..itemChest.defese.."] [DEX : "..itemChest.dexterity.."] [VIT : "..itemChest.life.."]" , 1, 3) end
        drawText("SEU ITEM" , 1, 5)
        if itemChest.type == "sword" and not(playerControl:getEquipSwordName() == "No Equiped") then drawText("["..playerControl:getEquipSwordName().."]\n[DMG : "..playerControl:getDamageSword().."] [CRIT : "..playerControl:getCriticalSword().."] [ACC : "..playerControl:getAccuracySword().."]" , 1, 6) elseif playerControl:getEquipSwordName() == "No Equiped" and itemChest.type == "sword" then drawText("Você não tem arma equipada!",1,6) end
       
        if itemChest.type == "armor" and not(playerControl:getEquipArmorName() == "No Equiped") then 
            drawText("["..playerControl:getEquipArmorName().."]\n[DEF : "..playerControl:getDefeseArmor().."] [DEX : "..playerControl:getDexterityArmor().."] [VIT : "..playerControl:getLifeArmor().."]" , 1, 6) 
        elseif playerControl:getEquipArmorName() == "No Equiped" and itemChest.type == "armor" then 
            drawText("Você não tem armadura equipada!",1,6) 
        end
        
        drawText("[E]   - Você Aceita a Troca" , 1, 8)
        drawText("[Q]   - Você Rejeita a Troca" , 1, 9)
    elseif state == "battle" then
        ---A FAZER
    elseif state == "winner" then
        --A FAZER
    end

    drawText("STATUS:" , 2, 1,"center")
    drawText("Força: "..playerControl:getDamage() + playerControl:getDamageSword() , 2, 2)
    drawText("Defesa: "..playerControl:getDefese() , 2, 3)
    drawText("Acuracia: "..playerControl:getAccuracy(), 2, 4)
    drawText("Destreza: "..playerControl:getDexterity() , 2, 5)
    drawText("Critico: "..playerControl:getCritical() , 2, 6)
    
    
    drawText("INVENTARIO:" , 3, 1, "center")

    -- Controle do SET na GUI
    love.graphics.setColor(1, 1, 1, 100)

    if (playerControl:getEquipArmorSprite() == nil) then
        love.graphics.draw(gui["noArmor"], 580, 460 )

    else
        love.graphics.draw(gui["noArmor"], 580, 460 )
        love.graphics.draw(playerControl:getEquipArmorSprite(), 580, 460 )

    end

    if (playerControl:getEquipSwordSprite() == nil) then
        love.graphics.draw(gui["noSword"], 580, 500 )

    else
        love.graphics.draw(gui["noSword"], 580, 500 )
        love.graphics.draw(playerControl:getEquipSwordSprite(), 580, 500 )

    end

    drawText("Vida: "..playerControl:getLife().."     Level: "..playerControl:getLevel() , 3, 6)
    drawText("XP: "..playerControl:getExp() , 3, 7)
    drawText("Sword: "..playerControl:getEquipSwordName() , 3, 8)
    drawText("Armor: "..playerControl:getEquipArmorName() , 3, 9)
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

    if state == "move" then
        local x = playerControl:getPy()
        local y = playerControl:getPx()

        if key == "right" or key == "d" then x = x+1  playerControl:setSprite("spriteRight") end
        if key == "left" or key == "a" then x = x-1 playerControl:setSprite("spriteLeft") end
        if key == "up" or key == "w" then y = y - 1 playerControl:setSprite("spriteUp")  end
        if key == "down" or key == "s" then  y = y + 1 playerControl:setSprite("spriteDown") end

        if  not (mapControl:isCollider(x,y) == 'x' or mapControl:isCollider(x,y) == 'x1')  then

            playerControl:setPx(x)
            playerControl:setPy(y)

        end

        if mapControl:isCollider(x,y) == 'c' then

            math.randomseed(os.time())
            local a = Itens:new()
            local numSort = math.random(2)
            if numSort == 1 then itemChest = a:getRandomSword() else itemChest = a:getRandomArmor() end
            mapControl:getMap()[y][x] = 'f'
            state = "chest"

        end

        if mapControl:isCollider(x,y) == 's' then

            mapControl = arrayMaps[mapControl:getMapLevel()+1]
            love.window.setTitle(mapControl:getNameMap())
            playerControl:setPx(2)
            playerControl:setPy(2)
            clearFog()

        end
    end

    if state == "chest" then
        
        if key == "e" then
            if itemChest.type == "sword" then playerControl:setEquipSword(itemChest) else playerControl:setEquipArmor(itemChest) end
            state = "move"
        end

        if key == "q" then
            state = "move"
        end

    end

end
