currentTileCode = ''
map = {}

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
        f = love.graphics.newImage("tiles/floor_1.png"), -- Chão Tipo 1
        f1 = love.graphics.newImage("tiles/floor_2.png"), -- Chão Tipo 2
        c = love.graphics.newImage("tiles/chest_1.png"), -- Bau Tipo 1
        c1 = love.graphics.newImage("tiles/chest.png"), -- Bau Tipo 2
        s = love.graphics.newImage("tiles/stair_1.png"), -- Escada
        m = love.graphics.newImage("tiles/monster_1.png"), -- Monstro Tipo 1
        m1 = love.graphics.newImage("tiles/monster_2.png"), -- Monstro Tipo 2
        m2 = love.graphics.newImage("tiles/monster_3.png"), -- Monstro Tipo 3
        m3 = love.graphics.newImage("tiles/monster_4.png"), -- Monstro Tipo 4
    }
    fullMap()
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
                currentTileCode = "x"
            end
            -- [Slot 2]
            if y > 35 and y < 52 then              
                currentTileCode = "c1"
            end
            -- Escada
            if y > 53 and y < 69 then               
                currentTileCode = "s"
            end
            -- Chão 1
            if y > 70 and y < 87 then                
                currentTileCode = "f"
            end 
             -- Bau 2
             if y > 88 and y < 105 then               
                currentTileCode = "c"
            end     
             -- Chão 2
             if y > 106 and y < 123 then
                currentTileCode = "f1"
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
    --print(map[1][1])
  
end

function love.keypressed(key, scancode)

    if key == "s" then
        saveMap()
    end

end

function saveMap()
    print("SAVE - MAP")
    save(map)

end

function save(m)
    local file = io.open("DungeonCrawler/mapEditor/data/data.lua", "w+")
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