currentTileCode = ''
map = {}
filename = ''
writeFileName = 0
functionMap = 'edit'
mapList = require('DungeonCrawler/MapLoad')


function fullMap()
    for i = 1, 25 do
        local linha = {}
        for j = 1, 25 do
            table.insert(linha,"f")
        end
        table.insert(map,linha)
    end
end

function drawGrid()
    for i = 1, table.getn(map) do
        for j = 1, table.getn(map[1]) do
            local code = map[i][j]
            love.graphics.draw(blocks[code], 0+(j*17), 0+(i*17))
            --love.graphics.rectangle("fill", 0+(j*17), 0+(i*17), 16, 16 )
        end
    end
end

function love.load()
    blocks = {
        x = love.graphics.newImage("tiles/wall.png"), -- Parede
        x1 = love.graphics.newImage("tiles/wall_3.png"), -- Parede
        f = love.graphics.newImage("tiles/floor_1.png"), -- Chão Tipo 1
        f1 = love.graphics.newImage("tiles/floor_2.png"), -- Chão Tipo 2
        f2 = love.graphics.newImage("tiles/floor_3.png"), -- Chão Tipo 3
        f3 = love.graphics.newImage("tiles/floor_4.png"), -- Chão Tipo 4
        f4 = love.graphics.newImage("tiles/floor.png"), -- Chão Tipo 5
        f5 = love.graphics.newImage("tiles/floor_5.png"), -- Chão Tipo 6
        c = love.graphics.newImage("tiles/chest_1.png"), -- Bau Tipo 1
        c1 = love.graphics.newImage("tiles/chest.png"), -- Bau Tipo 2
        s = love.graphics.newImage("tiles/stair_1.png"), -- Escada
        m = love.graphics.newImage("tiles/monster_1.png"), -- Monstro Tipo 1
        m1 = love.graphics.newImage("tiles/monster_2.png"), -- Monstro Tipo 2
        m2 = love.graphics.newImage("tiles/monster_3.png"), -- Monstro Tipo 3
        m3 = love.graphics.newImage("tiles/monster_4.png"), -- Monstro Tipo 4
    }
    fullMap()
    love.graphics.setFont(love.graphics.newFont("cc.otf", 14))

end


function drawAllTiles()
    local i = 1;
    for key, tile in pairs(blocks) do
        love.graphics.draw(tile, 455, 17+i)
        i = i + 17
    end
end

function mouseCursor()
    cursor = love.mouse.getSystemCursor("hand")
    local x, y = love.mouse.getPosition()

    if not (currentTileCode == '') then
        love.graphics.draw(blocks[currentTileCode], x, y)
    end
    --print(love.mouse.getCursor())
end

local correndo = 0
local mouse_x = nil
local mouse_y = nil

function love.mousereleased( x, y, button, istouch, presses )
    if  button == 1 then
        print("SOLTEI O PRESOO")
        correndo = 0
    end
end

function love.mousepressed(x, y, button)
    mouse_x = x
    mouse_y = y
    if  button == 1 then
        correndo = 1
        print('X['..x..'] Y['..y..']')
        -- Menu de Tiles Coluna = range do X
        if (x > 455 and x < 516) then
            --[Slot 1]
            if y > 17 and y < 34 then
                --love.mouse.setCursor(cursor)           
                currentTileCode = "f4"
                
            end
            -- [Slot 2]
            if y > 35 and y < 52 then              
                currentTileCode = "x"
            end
            -- [Slot 3]
            if y > 53 and y < 69 then               
                currentTileCode = "c1"
            end
            -- [Slot 4]
            if y > 70 and y < 87 then                
                currentTileCode = "f5"
            end 
             -- [Slot 5]
             if y > 88 and y < 105 then               
                currentTileCode = "m2"
            end     
             -- [Slot 6] ---------------------
             if y > 106 and y < 123 then
                currentTileCode = "c"
             end
             -- [Slot 7]
             if y > 123 and y < 140 then
                currentTileCode = "f1"
             end
            -- [Slot 8]
            if y > 141 and y < 158 then
                currentTileCode = "m3"
            end
            -- [Slot 9]
            if y > 159 and y < 176 then
                currentTileCode = "x1"
            end
            -- [Slot 10]
            if y > 177 and y < 194 then
                currentTileCode = "f2"
            end
            -- [Slot 11]
            if y > 195 and y < 212 then
                currentTileCode = "m1"
            end
            -- [Slot 12]
            if y > 213 and y < 230 then
                currentTileCode = "m"
            end
            -- [Slot 13]
            if y > 231 and y < 248 then
                currentTileCode = "f3"
            end
            -- [Slot 14]
            if y > 249 and y < 266 then
                currentTileCode = "s"
            end
            -- [Slot 15]
            if y > 267 and y < 284 then
                currentTileCode = "f"
            end
            love.mouse.setVisible(false)
        end

        

       

    end


    if  button == 2 then
        love.mouse.setVisible(true)
        currentTileCode = ''
    end
end

function love.mousemoved( x, y, dx, dy, istouch )
    if correndo == 1 then
        print('DX['..dx..'] DY['..dy..']')
        mouse_x = x+dx
        mouse_y = y+dy
    end
end

function paintTile(x, y)

    --print("X: "..x.."Y: "..y)
    if not (currentTileCode == '') then map[math.floor(y/17)][math.floor(x/17)] = currentTileCode end


end

function love.draw()
   -- love.graphics.setColor(1, 0, 0)
   -- for i = 1, 15 do
    --    love.graphics.rectangle("fill", 450, (i*17), 40, 16 )
   -- end
   

    love.graphics.setColor(1, 1, 1)

    drawGrid()
    drawAllTiles()
    mouseCursor()

    drawMenu()
    if correndo == 1 and mouse_x > 17 and mouse_x < 440 and mouse_y > 17 and mouse_y < 440 then
        paintTile(mouse_x,mouse_y)
    end
        
  
end

function drawMenu()
    love.graphics.print("Mapas Disponiveis: ", 530, 20)
    love.graphics.setColor(0, 1, 0)

    for i = 1, table.getn(mapList) do
        
        love.graphics.print(i.." - "..mapList[i], 530, 20+(20*i))

    end





    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 20, 450, 420, 188 )
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Nome do Mapa: ", 30, 460)
    love.graphics.setColor(1, 0, 0)
    love.graphics.print(filename, 150, 460)

    love.graphics.setColor(0, 0, 1)
    love.graphics.print("Instruções:\n Pressione F1 para Abrir um MAPA\n Pressione F2 para Salvar um Mapa \n(Se não colocar nome ele será salvo como data.lua )\n Pressione F5 para resetar o nome\n Pressione F6 para Gerar um novo Mapa com o Tile Selecionado\nna Seta\n Pressione F7 para gerar Bordas para o Mapa", 30, 480)

    love.graphics.setColor(0,1,0)
    if writeFileName == 0 then
        if functionMap == 'edit' then
            love.graphics.print("Edição", 290, 645)
        elseif functionMap == 'edit_save' then
            love.graphics.setColor(1, 0, 1, 0.6)
            love.graphics.print("Mapa SALVO", 290, 645)
            love.graphics.setColor(1, 1, 1, 0.6)
        end
    else
        love.graphics.setColor(1, 0, 1, 0.6)
        love.graphics.rectangle("fill", 25, 155, 400, 100 )

        love.graphics.setColor(1, 1, 1, .8)
        love.graphics.rectangle("fill", 30, 160, 390, 90 )

        love.graphics.setColor(0,0,0,1)
        if functionMap == 'open' then
            love.graphics.printf("ABRIR MAPA:\n(Digite o Nome de um Mapa para Abrir)\nPressione F1 para Abrir\nPressione F5 para Limpar o Nome\nPressione ESC para Sair sem Abrir", 30, 160,400,"center")
        elseif functionMap == 'save' then
            love.graphics.printf("SALVAR MAPA:\n(Digite o Nome do Mapa para Salvar)\nPressione F2 para Salvar\nPressione F5 para Limpar o Nome\nPressione ESC para Sair sem Salvar", 30, 160,400,"center")
        end

        love.graphics.setColor(0,1,0)
        love.graphics.print("Escrevendo o Nome do Arquivo", 290, 645)
    end
    love.graphics.setColor(1,1,1)



end

function love.keypressed(key, scancode)
    -- Sair
    if key == "escape" then
        --love.event.quit()
        functionMap = 'edit'
        writeFileName = 0
     end

     -- Abrir Mapa
     if key == "f1" then
        if writeFileName == 1 and not(filename == '')then
            map = require("DungeonCrawler/maps/"..filename)
            writeFileName = 0
            functionMap = 'edit'
        else
            writeFileName = 1
            functionMap = 'open'
        end
     end

     -- Salvar Mapa
    if key == "f2" then
        if writeFileName == 1 then
            save(map)
            writeFileName = 0
            functionMap = 'edit_save'
        else
            writeFileName = 1
            functionMap = 'save'
        end
    end
    
     -- Limpar Nome
     if key == "f5" then
        filename = ''
        print("Clear FileName")
     end
         
     -- Novo Mapa
     if key == "f6" then
        newMap()
        print("New Map")
     end

     -- Novo Mapa
     if key == "f7" then
        drawBorder()
        print("Border Print")
     end

end

function drawBorder()
    if currentTileCode == '' then currentTileCode = 'x' end

    --Printa os X
    for i = 1, table.getn(map) do
        if i == 1 or i == table.getn(map) then
            for j = 1, table.getn(map) do
                map[i][j] = currentTileCode
            end
        end
    end

        --Printa os Y
        for i = 1, table.getn(map) do
            for j = 1, table.getn(map) do
                if j == 1 or j == table.getn(map[1]) then
                    map[i][j] = currentTileCode
                end
            end
        end
end

function newMap()
    if currentTileCode == '' then currentTileCode = 'f' end
    for i = 1, table.getn(map) do
        for j = 1, table.getn(map[1]) do
            map[i][j] = currentTileCode
        end
    end
    currentTileCode = ''
    love.mouse.setVisible(true)
end

function love.textinput(t)
    if writeFileName == 1 then
        filename = filename .. t
        print(filename)
    end
end



function save(m)
    print("SAVE - MAP")
    if filename == '' then filename = "data" end

    local file = io.open("DungeonCrawler/maps/"..filename..".lua", "w+")
    io.output(file)
    io.write("    return {\n")
    for i = 1, table.getn(m) do
        io.write("        {")
        for j = 1, table.getn(m[1]) do
            --print("M["..i.."]["..j.."] = "..m[i][j])
            io.write("\""..m[i][j].."\"")
            if not(j == table.getn(m[1])) then io.write(",") end
        end
        io.write("},\n")
    end
    io.write("    }")
    file:close()
    saveMap()
end

function saveMap()
    
    local file2 = io.open("DungeonCrawler/MapLoad.lua", "w")
    io.output(file2)

    io.write("names = {\n")
    for i = 1 , table.getn(mapList) do
        io.write("    \""..mapList[i].."\",\n")
    end
    io.write("    \""..filename.."\",\n")
    io.write("}\nreturn names")
    io.close(file2)
end