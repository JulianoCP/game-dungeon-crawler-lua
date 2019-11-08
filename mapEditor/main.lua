currentTileCode = ''
map = {}
filename = ''
writeFileName = 0

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

function love.mousepressed(x, y, button)

    if  button == 1 then

        -- Menu de Tiles Coluna = range do X
        if (x > 445 and x < 516) then
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

        paintTile(x,y)

       

    end
    if  button == 2 then
        love.mouse.setVisible(true)
        currentTileCode = ''
    end
end

function paintTile(x, y)

    --print("X: "..x.."Y: "..y)
    if not (currentTileCode == '') then map[math.floor(y/17)][math.floor(x/17)] = currentTileCode end


end

function love.draw()
    --love.graphics.scale(1.5, 1.5)

    drawGrid()
    drawAllTiles()
    mouseCursor()

    drawMenu()
  
end

function drawMenu()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 20, 450, 420, 188 )
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Nome do Arquivo: ", 30, 460)
    love.graphics.setColor(1, 0, 0)
    love.graphics.print(filename, 150, 460)

    love.graphics.setColor(0, 0, 1)
    love.graphics.print("Instruções:\n Pressione S para Salvar\n Pressione F2 para editar o nome do Mapa \n(Se não colocar nome ele será salvo como data.lua )\n Pressione F5 para resetar o nome", 30, 500)

    love.graphics.setColor(0,1,0)
    if writeFileName == 0 then
        love.graphics.print("Edição", 290, 645)
    else
        love.graphics.print("Escrevendo o Nome do Arquivo", 290, 645)
    end
    love.graphics.setColor(1,1,1)


end

function love.keypressed(key, scancode)

    if key == "s" then
        if writeFileName == 0 then
            save(map)
        end
    end
    if key == "f2" then
        if writeFileName == 1 then
            writeFileName = 0
        else
            writeFileName = 1
        end
    end
    if key == "escape" then
        love.event.quit()
     end
    
     if key == "o" then
        if  writeFileName == 0 then
            map = require("DungeonCrawler/maps/"..filename)
        end
     end

     if key == "f5" then
        filename = ''
     end

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
    local filename = "DungeonCrawler/maps/"..filename..".lua"
    local file = io.open(filename, "w+")
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
end

function load()
    local file = io.open("mapEditor/data/data.lua", "r")
    if file then
        local string = file:read()
        print(string)
        local string = file:read()
        print(string)
        file:close()
        print("LOAD IN")
    end
end