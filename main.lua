
Map = require 'Map'
Player = require 'Player'
Itens = require 'Itens'
state = "move"


local mapControl = nil

function love.load()

    love.graphics.setFont(love.graphics.newFont("assets/fonts/cc.otf", 14))

    local m = {
        {"x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x"},
        {"x","f","f1","c","c","c","c","c","f","f","f","s","f","f","f","f","f","f","f","f","f","f","f","c","x"},
        {"x","x","x","x","x","x","x","f","x","x","x","x","x","x","f","x","x","x","x","x","x","x","x","x","x"},
        {"x","f","x","c","f","x","f1","f","f","x","f","x","f","x","f","x","f","f","x","f","f","f","f","f","x"},
        {"x","f","x","f","f","x","f","f","f","x","f","x","f","f","f","x","f","f","x","f","x","f","f","f","x"},
        {"x","f","x","x","f","x","x","f","x","x","f","x","f","x","f","f","f","f","x","f","x","f","f","c","x"},
        {"x","f","f","f","f","f","x","f1","x","f","f","f","f","x","f","f","x","x","x","f","x","x","x","x","x"},
        {"x","x","x","x","x","f","x","f","x","f","x","x","x","x","f","f","f","f","x","f","f","f","f","f","x"},
        {"x","f","f","f","f","f","x","f","x","f","f","f","f","x","x","x","f","f","x","x","x","x","x","f","x"},
        {"x","f","x","f","f","f","x","f1","x","f","f1","f1","f","x","f","f","f","f","x","f","f","f","x","f","x"},
        {"x","f","x","x","x","x","x","f","x","x","x","x","x","x","f","x","f","x","x","f","f","f","x","f","x"},
        {"x","f","f","f","f","f","f1","f","f1","f","f1","f","f","f","f","x","f","f","f","f","x","x","x","f","x"},
        {"x","x","f","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","f","f","f","x","f","x"},
        {"x","f","f","x","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","x"},
        {"x","f","f","x","f","f","f","f","x","f","x","x","x","x","x","x","x","x","x","x","x","x","x","f","x"},
        {"x","f","f","x","f","f","f","f","x","f","x","c","f","f","f","f","f","f","f","f","f","f","x","f","x"},
        {"x","f","f","x","c","f","f","f","x","f","x","f","f","f","f","x","x","x","x","x","f","f","x","f","x"},
        {"x","f","f","x","x","x","x","x","x","f","x","f","f","f","f1","x","f","f","f","x","f","f","x","f","x"},
        {"x","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","x"},
        {"x","f","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","f","x"},
        {"x","f","f","f","f","f","f","f","f","f","x","f","f","f","f","f","f","f","f","f","f","f","x","f","x"},
        {"x","f","x","f","f","f","f","f","f","c","x","f","f","f","f","f","f","f","f","f","f","c","x","f","x"},
        {"x","f","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","f","x"},
        {"x","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","f","x"},
        {"x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x"},
    }
    fog = {
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
        {"w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w","w"},
    }

    -- futuramente trocar M por um arquivo
    mapControl = Map:new("Santuario", m, 1)
    mapData = mapControl:getMap();

    playerControl = Player:new(2,2,"spriteRight")

    blocks = {
        x = love.graphics.newImage("assets/tiles/wall.png"), -- Parede
        f = love.graphics.newImage("assets/tiles/floor_1.png"), -- Chão Tipo 1
        f1 = love.graphics.newImage("assets/tiles/floor_2.png"), -- Chão Tipo 2
        c = love.graphics.newImage("assets/obj/chest_1.png"), -- Bau Tipo 1
        c1 = love.graphics.newImage("assets/obj/chest.png"), -- Bau Tipo 2
        s = love.graphics.newImage("assets/tiles/stair_1.png"), -- Escada
    }

    gui ={
        interface = love.graphics.newImage("assets/gui/gui_interface.png"),
        chest = love.graphics.newImage("assets/gui/dungeonChest.png"),
        dungeon = love.graphics.newImage("assets/gui/dungeonWalking.png"),
        frame = love.graphics.newImage("assets/gui/interface_scene.png")
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
    elseif myX == 3 then
        myX = 670
        padding = 150
    end

    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.printf(text, myX, myY, padding, align)
end

function drawMenu()

    drawText("COMANDO:", 1, 1, "center")
    drawText("→   - Mover para Direita" , 1, 2)
    drawText("←   - Mover para Esquerda" , 1, 3)
    drawText("↑      - Mover para Cima" , 1, 4)
    drawText("↓      - Mover para Cima" , 1, 5)
    drawText("↓      - Teste Linha[6]Coluna[1]" , 1, 6)
    drawText("↓      - Teste Linha[7]Coluna[1]" , 1, 7)
    drawText("↓      - Teste Linha[8]Coluna[1]" , 1, 8)
    drawText("↓      - Teste Linha[9]Coluna[1]" , 1, 9)
    
    drawText("STATUS:" , 2, 1,"center")
    drawText("Força: "..playerControl:getDamage() , 2, 2)
    drawText("Defesa: "..playerControl:getDefese() , 2, 3)
    drawText("Acuracia: "..playerControl:getAccuracy(), 2, 4)
    drawText("Destreza: "..playerControl:getDexterity() , 2, 5)
    drawText("Critico: "..playerControl:getCritical() , 2, 6)
    
    
    drawText("INVENTARIO:" , 3, 1, "center")
    drawText("Vida: "..playerControl:getLife().."     Level: "..playerControl:getLevel() , 3, 6)
    drawText("XP: "..playerControl:getExp() , 3, 7)
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(gui["interface"], 0, 0 )
    love.graphics.draw(gui["dungeon"], 420, 10 )
    
    --love.graphics.rectangle("fill", 10, 420, 810, 250 )

    drawMap(mapData)
    drawPlayer()
    drawScene()
    drawMenu()

    
end

function drawScene()

    if state == "chest" then
        love.graphics.draw(gui["chest"], 420,10 )
    end

end

function love.keypressed(key, scancode)

    if key == "m" then  state = "move" end

    if state == "move" then
        local x = playerControl:getPy()
        local y = playerControl:getPx()

        if key == "right" then x = x+1  playerControl:setSprite("spriteRight") end
        if key == "left" then x = x-1 playerControl:setSprite("spriteLeft") end
        if key == "up" then y = y - 1 playerControl:setSprite("spriteUp")  end
        if key == "down" then  y = y + 1 playerControl:setSprite("spriteDown") end

        if  not (mapControl:isCollider(x,y) == 'x')  then
            playerControl:setPx(x)
            playerControl:setPy(y)
        end

        if mapControl:isCollider(x,y) == 'c' then
            a = Itens:new()
            print(a:getRandomSword())
            mapData[y][x] = 'f'
            state = "chest"
        end

        if mapControl:isCollider(x,y) == 's' then
            -- Vai para um novo Nivel
            -- state = "chest"
            print("ACHOU UMA ESCADA")
        end

    end

end
