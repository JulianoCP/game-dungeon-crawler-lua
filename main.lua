------- [ Require ] -------
Monster = require 'Monster' -- Load class Monster
Player = require 'Player'   -- Load class Player
blocks = require 'Blocks'   -- Load class Blocks
names = require 'MapLoad'   -- Load class Names
Itens = require 'Itens'     -- Load class Itens
FogWar = require 'Fog'      -- Load class Fog
Map = require 'Map'         -- Load class Map
gui = require 'Gui'         -- Load class Gui

------- [ Flag Control ] -------
pressKeyForDmgEnemy = false -- Verify key for damage monster is pressed
changeColortText = false    -- Verify to change color text status
pressBattleAway = false     -- Verify key for start battle
deadMonsterFlag = false     -- Verify if the monster dead
playerLoseLife = false      -- Verify if the player lose life
monsterAttack = false       -- Verify if the monster attack
isLevelUpdate = false       -- Verify if the player up level
pressRunAway = false        -- Verify key for player run away
criticalFlag = false        -- Verify if the player damage is critical
currentMonster = {}         -- Verify the current monster
playerControl = nil         -- Controller the player
arrayMonster = nil          -- List of monsters
mapControl = nil            -- Controller the map
itemChest = nil             -- Controller the chest
missorhit = nil             -- Verify if is hit or miss
utility = false             -- Variavel Utility
turnAtk = true              -- Verify who's the turn
isHitM = false              -- Verify if is possible the hit in monster
isHit = false               -- Verify if is possible the hit in plyer
isMenu = true               -- Verify Menu exist
button_menu = true          -- Blink Effect Button

------- [ Base Control ] -------
damageHitMonster = 0        -- Verify damage of hit monster
damageHitPlayer = 0         -- Verify damage of hit player
currentCritical = 1         -- Verify if is critical
numberTryToRun = 0          -- Verify if is possible the run away
baseLifePlayer = 0          -- Verify base life player
maxCritical = 10            -- Verify max critical
potionHeal = 20             -- Verify quantity of healing in the potion
state = "move"              -- Verify current state in game

------- [ Map Control ] -------
arrayMonsterName = {'m','m1','m2','m3'} -- List of maps name
missorhitMonster = nil      -- Verify hit or miss of monster
typeMonster = nil           -- Verify type of monster
arrayMaps = {}              -- List maps
My = 0                      -- Verify position My in map
Mx = 0                      -- Verify position Mx in map
allItens = Itens:new()      -- List all Itens

------- [ Function Init in lua ] -------
function love.load()
    
    
    --love.keyboard.setKeyRepeat(true)
    
    a = Itens:new()
    arrayMonster = Monster:new()

    local maps = nil
    fog = FogWar
    love.graphics.setFont(love.graphics.newFont("assets/fonts/cc.otf", 14))
    
    -- Load all maps
    for i = 1, table.getn(names) do
        maps = Map:new("Labirinto - "..names[i] , require("/maps/"..names[i]) , i)
        table.insert( arrayMaps, maps )
    end

    mapControl = arrayMaps[1]
    love.window.setTitle(mapControl:getNameMap())

    -- Set player char
    playerControl = Player:new(2,2,"spriteRight")

    baseLifePlayer = playerControl:getLife()

end

------- [ Function draw player in the window ] -------
function drawPlayer()

    local width = playerControl:getSprite():getDimensions()
    love.graphics.setColor(1, 1, 1, 100) 
    love.graphics.draw(playerControl:getSprite(), (width*playerControl:getPy())-6, (width*playerControl:getPx())-6 )
    
end

------- [ Function draw map in the window ] -------
function drawMap(map)
    love.graphics.setColor(1, 1, 1, 100) -- Cor Original
    local width = blocks["x"]:getDimensions()

    -- Draw Original Map
    for i = 1, table.getn(map) do
        for j = 1 , table.getn(map[1]) do
            local code = map[i][j]
            love.graphics.draw(blocks["f"], (width*j)-6, (width*i)-6)
            love.graphics.draw(blocks[code], (width*j)-6, (width*i)-6)
        end
    end
    
    -- Draw Fog Alpha 0.5
    for i = 1 , table.getn(fog) do
        for j = 1 , table.getn(fog) do
            if fog[i][j] == "k" then
                fog[i][j] = "j"
            end
        end
    end
    
    -- Clear Fog
    for i = playerControl:getPx() - 1 , playerControl:getPx() + 1 do
        for j = playerControl:getPy() - 1 , playerControl:getPy() + 1 do
            if i <= 1 then i = 1 end
            if j <= 1 then j = 1 end
            fog[i][j] = "k"
        end
    end

    -- Draw BlackOut
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

------- [ Function draw text in the window ] -------
function drawText(text, x, y, align)

    local myY = y
    local myX = x
    local padding = 300

    -- Set align to left
    if align == nil then align = "left" end

    -- Set line in windowns
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

    -- Set Col in windowns
    if myX == 1 then myX = 28 padding = 250
        elseif myX == 2 then myX = 300 padding = 240
        elseif myX == 3 then myX = 580 padding = 220
    end

    -- Set color Text
    if changeColortText == false then love.graphics.setColor(0, 0, 0, 100)
    elseif changeColortText == true then love.graphics.setColor(1, 0, 0, 100)  end
    love.graphics.printf(text, myX, myY, padding, align)

end

------- [ Function draw stats text in the windowns ] -------
function  drawStat(text, x, y)
    
    local myY = y
    local myX = x
    local padding = 300
    
    -- Set Line in windowns
    if myX == 1 then myX = 238 end
    if myX == 2 then myX = 304 end
    if myX == 3 then myX = 370 end

     -- Set Line in windowns
    if myY == 1 then myY = 460
        elseif myY == 2 then myY = 485
        elseif myY == 3 then myY = 510
        elseif myY == 4 then myY = 535
        elseif myY == 5 then myY = 560
        elseif myY == 6 then myY = 585
    end

     -- Set color Text
    love.graphics.setColor(0, 0, 0, 100)
    if text < 0 then love.graphics.setColor(1, 0, 0, 100) end
    love.graphics.printf(text, myX, myY, padding, "center")

end

------- [ Function draw commands in the window ] -------
function drawMenu()

    if playerControl:getLife() == playerControl:getMaxLife() then playerLoseLife = false end

    -- Change current state for move
    if state == "move" then

        --drawText("                COMANDO:", 1, 1)
        love.graphics.setColor(1, 1, 1, 100)
        love.graphics.draw(gui["command_button"], 60, 410 )

        drawText("[D] ou ( → ) - Move Right" , 1, 2)
        drawText("[A] ou ( ← ) - Move Left" , 1, 3)
        drawText("[W] ou  ( ↑ ) - Move Up" , 1, 4)
        drawText("[S] ou  ( ↓ ) - Mover Down" , 1, 5)
        drawText("[F] - Use Health Potion" , 1, 6)

    -- Change current state for chest
    elseif state == "chest" then
        
        --drawText("                COMANDO:", 1, 1)
        love.graphics.setColor(1, 1, 1, 100)
        love.graphics.draw(gui["chest_button"], 60, 410 )
        drawText("You Found an Item" , 1, 2)

        if itemChest.type == "sword" then drawText("["..itemChest.name .."]\n[DMG : "..itemChest.damage.."] [CRIT : "..itemChest.critical.."] [ACC : "..itemChest.accuracy.."]" , 1, 3) end
        if itemChest.type == "armor" then drawText("["..itemChest.name.."]\n[DEF : "..itemChest.defese.."] [DEX : "..itemChest.dexterity.."]" , 1, 3) end 
        if itemChest.type == "potion" then drawText("[POTION] + [ 1 ]" , 1, 3) end 
        drawText("My Item" , 1, 5)

        if itemChest.type == "sword" and not(playerControl:getEquipSwordName() == "Not Equiped") then drawText("["..playerControl:getEquipSwordName().."]\n[DMG : "..playerControl:getDamageSword().."] [CRIT : "..playerControl:getCriticalSword().."] [ACC : "..playerControl:getAccuracySword().."]" , 1, 6) elseif playerControl:getEquipSwordName() == "Not Equiped" and itemChest.type == "sword" then drawText("You dont have sword equipped!",1,6) end
        if itemChest.type == "armor" and not(playerControl:getEquipArmorName() == "Not Equiped") then drawText("["..playerControl:getEquipArmorName().."]\n[DEF : "..playerControl:getDefeseArmor().."] [DEX : "..playerControl:getDexterityArmor().."]" , 1, 6) elseif playerControl:getEquipArmorName() == "Not Equiped" and itemChest.type == "armor" then drawText("You dont have armor equipped!",1,6) end
        if itemChest.type == "potion" then drawText("[POTION] = ".."[ "..playerControl:getInventoryPotion().." ]" , 1, 6) end

        if itemChest.type == "armor" or itemChest.type == "sword" then
            drawText("[E]   - Do You Want the Item" , 1, 8)
            drawText("[Q]   - Do You Rejected the Item" , 1, 9)
        elseif itemChest.type == "potion" then
            drawText("[E]  - You Picked the Health Potion" , 1, 8)
            drawText("[Q]  - You Descarted the Health Potion" , 1, 9)
        end

    -- Change current state for battle 
    elseif state == "battle" then
     
        --drawText("BATTLE:", 1, 1, "center")
        love.graphics.setColor(1, 1, 1, 100)
        love.graphics.draw(gui["battle_button"], 60, 410 )

        if not(deadMonsterFlag) then

            if pressRunAway == false and pressBattleAway == false then
                drawText("[E] ou (←)   - Start the battle" , 1, 3)
                drawText("[Q] ou (→)   - Try to run away" , 1, 4)    
            end

            if pressBattleAway == true then
                
                drawText("["..arrayMonster[typeMonster].name.."]" , 1, 2)
                drawText(arrayMonster[typeMonster].msg , 1, 3)
                drawText("Monster Life: "..currentMonster.life , 1, 5)
                drawText("[A]  - Attack" , 1, 6)
                drawText("[F]  - Use Health Potion" , 1, 7 )

                if missorhit == false then drawText("You Missed the Attack" , 1, 8 ) elseif isHit == true and missorhit == true and criticalFlag == false then drawText("You Hitted Attack : "..damageHitPlayer , 1, 8 ) end
                if monsterAttack == true  then drawText("The Monster Hitted "..damageHitMonster.." on Me" , 1, 9 ) elseif isHitM == true  then drawText("The Monster Missed the Attack" , 1, 9 )  end
                if isHit == true and criticalFlag and missorhit == true then changeColortText = true drawText("Critical Attack : ".. damageHitPlayer.." !!!" , 1, 8 ) changeColortText = false end
                if missorhit == true then isHit = true end               
                
                if pressKeyForDmgEnemy == true  then
                    
                    if currentMonster.life > 0 and missorhit then
                        if math.random(maxCritical) <= playerControl:getCritical()+playerControl:getCriticalSword() then
                            currentCritical = 2
                            criticalFlag = true
                        end
                        pressKeyForDmgEnemy = false
                        if ((playerControl:getDamage()+playerControl:getDamageSword()) * currentCritical) <= currentMonster.defese then
                            missorhit = false
                            isHit = false
                        else
                            local losslife = ( ((playerControl:getDamage()+playerControl:getDamageSword()) * currentCritical) - currentMonster.defese)
                            currentMonster.life = currentMonster.life - losslife
                            damageHitPlayer = losslife
                        end
      
                        if currentMonster.life <= 0 then currentMonster.life = 0 pressBattleAway = true end
                    elseif not(missorhit)then
                        missorhit = false
                        isHit = false
                    end
                    turnAtk = false    
                end
                if currentMonster.life == 0 then
                    pressBattleAway = false
                    pressKeyForDmgEnemy = false
                    deadMonsterFlag = true
                    turnAtk = nil
                    mapControl:getMap()[My][Mx] = "f"
                    lootMonster()
                end
            end
        end

        if turnAtk == false and not(deadMonsterFlag) then
       
            if playerControl:getLife() > 0 and missorhitMonster  and not(currentMonster.life == 0)then
                if math.random(maxCritical) <= currentMonster.critical then
                    currentCritical = 2
                end
                if (currentMonster.damage*currentCritical) <= playerControl:getDefese()+playerControl:getDefeseArmor() then
                    isHitM = true
                else 
                    local losslife = ((currentMonster.damage*currentCritical)-(playerControl:getDefese()+playerControl:getDefeseArmor()) ) 
                    playerControl:setLife(playerControl:getLife()-losslife)
                    isHitM = false
                    turnAtk = true
                    damageHitMonster = losslife
                    monsterAttack = true
                    playerLoseLife = true
                end

                if playerControl:getLife()<= 0 then playerControl:setLife(0) state = "died" end                  
            elseif not(missorhitMonster) then
                isHitM = true
            end
            turnAtk = true  
  
        end
        if playerControl:getLife() <= 0 then
            state = "died"
        end
        
        if deadMonsterFlag == true then
            drawText("You won the battle" , 1, 2 )

            if isLevelUpdate == true then 
                changeColortText = true
                drawText("You Leveled UP!! " , 1, 5)
                changeColortText = false
            end
            drawText("You won: "..currentMonster.expWin.." XP" , 1, 3 )
            drawText("[A] - You will leave the battle " , 1, 4 )
        end

        if pressRunAway == true then
            if numberTryToRun <= 30 then 
                drawText("You Can Run Away" , 1, 2) 
                drawText("[V]   - To run away" , 1, 4)
                elseif numberTryToRun > 30 and numberTryToRun > 0 then
                    drawText("You Could not run away" , 1, 2) 
                    drawText("[C]   - Start the battle" , 1, 4)
            end
        end

    -- Change current state for died
    elseif state == "died" then
        love.graphics.setColor(1, 0 , 0, 0.7)
        love.graphics.rectangle("fill", 50, 130, 730, 180 )
        love.graphics.setColor(1, 1 , 1)
        
        love.graphics.draw(gui["youdied"], 50, 130 )
        love.graphics.setColor(1, 1, 1, 100)
        love.graphics.draw(gui["died_button"], 60, 410 )
        drawText("[R] To Restart the game !" , 1, 2)
        drawText("[Q] To Quit the game !" , 1, 3)
            
    end

    -- Draw Color in Stats Column
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
   
    -- Draw Stats STR
    drawText("                    SWORD      ARMOR      BASE" , 2, 1)
    drawText("STR: "..playerControl:getDamage()+playerControl:getDamageSword(), 2, 2)
    drawStat(playerControl:getDamageSword(), 1,1)
    drawStat(playerControl:getDamage(), 3,1)
    
    -- Draw Stats DEF
    drawText("DEF: "..playerControl:getDefese()+playerControl:getDefeseArmor(), 2, 3)
    drawStat(playerControl:getDefeseArmor(), 2,2)
    drawStat(playerControl:getDefese(), 3,2)
    
    -- Draw Stats ACC
    drawText("ACC: "..playerControl:getAccuracy()+playerControl:getAccuracySword(), 2, 4)
    drawStat(playerControl:getAccuracySword(), 1,3)
    drawStat(playerControl:getAccuracy(), 3,3)
    
    -- Draw Stats DEX
    drawText("DEX: "..playerControl:getDexterity()+playerControl:getDexterityArmor(), 2, 5)
    drawStat(playerControl:getDexterityArmor(), 2,4)
    drawStat(playerControl:getDexterity(), 3,4)

    -- Draw Stats CRT
    drawText("CRT: "..playerControl:getCritical()+playerControl:getCriticalSword(), 2, 6)
    drawStat(playerControl:getCriticalSword(), 1,5)
    drawStat(playerControl:getCritical(), 3,5)

    -- Draw Stats VIT
    if playerLoseLife == false then
        drawText("VIT: "..playerControl:getLife(), 2, 7)
        drawStat(baseLifePlayer, 3,6)
    elseif playerLoseLife then
        changeColortText = true
        drawText("VIT: "..playerControl:getLife(), 2, 7)
        drawStat(baseLifePlayer, 3,6)
        changeColortText = false
    end
    
    -- Draw Level and XP
    drawText("    Level: "..playerControl:getLevel(), 3, 2)
    drawText("    XP: "..playerControl:getXP(), 3, 3)

    -- Inventory GUI
    
    love.graphics.setColor(1, 1, 1, 100)
    
    -- Draw Armor if exist
    if (playerControl:getEquipArmorSprite() == nil) then
        love.graphics.draw(gui["noArmor"], 590, 540 )
        
    else
        love.graphics.draw(gui["noArmor"], 590, 540 )
        love.graphics.draw(playerControl:getEquipArmorSprite(), 590, 540 )
        
    end
    
    -- Draw Sword if exist
    if (playerControl:getEquipSwordSprite() == nil) then
        love.graphics.draw(gui["noSword"], 590, 580 )
        
    else
        love.graphics.draw(gui["noSword"], 590, 580 )
        love.graphics.draw(playerControl:getEquipSwordSprite(), 590, 580 )
    end

    drawText("\n\n"..playerControl:getEquipArmorName() , 3, 4,'center')
    drawText(playerControl:getEquipSwordName() , 3, 7,'center')
    
    love.graphics.setColor(1, 1, 1, 100)
    
    local potionQtd = 0
    for i = 1, playerControl:getInventoryPotion() do
        love.graphics.draw(gui["potion"], 586+potionQtd, 621 )
        potionQtd = potionQtd + 36
    end
        
    end

------- [ Function draw interface in the window ] -------
function drawScene()
    if state == "chest" then -- Select chest
        love.graphics.draw(gui["chest"], 420,10 )
    elseif state == "battle" then -- Select battle
        love.graphics.draw(gui["monster"], 420,10 )
    end
end

------- [ Function draw(loop) in the window ] -------
function love.draw()

    --[[Menu]] 
    if isMenu then 
        love.graphics.draw(gui["menu"], 0, 0 )
        love.timer.sleep( 0.5 )
        if button_menu then
            love.graphics.draw(gui["button_menu"], 15, 300 )
            button_menu = false
        else
            button_menu = true
        end
    else
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(gui["dungeon"], 420, 10 )
        love.graphics.draw(gui["interface"], 0, 0 )
    
        drawMap(mapControl:getMap()) -- Load current Map
        drawPlayer() -- Draw Player
        drawScene() -- Draw Scene
        drawMenu() -- Draw Menu
    end

end

------- [ Function reset the fog map ] -------
function clearFog()
    for i = 1 , table.getn(fog) do
        for j = 1 , table.getn(fog[1]) do
            fog[i][j] = "w"
        end
    end
end

------- [ Function capture key pressed ] -------
function love.keypressed(key, scancode)

    -- Player coordinates
    local x = playerControl:getPy()
    local y = playerControl:getPx()
    
    -- Menu 
    if key == 'return' then isMenu = false end

    -- Use Potion
    if key == 'f' then
        if playerControl:getInventoryPotion() > 0 then 
            playerControl:setInventoryPotion(-1)
            if ( playerControl:getLife() + potionHeal ) > playerControl:getMaxLife() then playerControl:setLife(playerControl:getMaxLife()) 
            elseif playerControl:getLife() <  playerControl:getMaxLife() then playerControl:setLife( playerControl:getLife() + potionHeal ) end
        end
    end 

    -- State Battle
    if state == "battle" then

        if key == "a" and pressBattleAway == true then pressKeyForDmgEnemy = true missorhit = isHitPlayer() missorhitMonster = isHitMonster() currentCritical = 1 criticalFlag = false dmgLow = false monsterAttack = false damageHitMonster = 0 end
        if key == "a" and deadMonsterFlag == true and pressBattleAway == false then state = "move" deadMonsterFlag = false end
        if key == "e" and pressBattleAway == false then activeBattle() pressBattleAway = true isHit = false isHitM = false missorhit = nil end

        if key == "q" and pressBattleAway == false and pressRunAway == false then
            pressRunAway = true
            math.randomseed(os.clock())
            numberTryToRun = math.random(255)
        end
        if key == "v" and pressRunAway == true and numberTryToRun <= 30 then pressRunAway = false state = "move" numberTryToRun = 0 tryToRun() end
        if key == "c" and pressRunAway == true and numberTryToRun > 30 then pressRunAway = false pressBattleAway = true  numberTryToRun = 0 activeBattle() end
    end

    -- Movement Arrows and buttons
    if state == "move" and isMenu == false then

        if key == "right" or key == "d" and not (mapControl:isColliderInside(x + 1,y) == 'x' or mapControl:isColliderInside(x,y) == 'x1') then x = x+1  playerControl:setSprite("spriteRight") end
        if key == "left" or key == "a" and not (mapControl:isColliderInside(x - 1,y) == 'x' or mapControl:isColliderInside(x,y) == 'x1') then x = x-1 playerControl:setSprite("spriteLeft") end
        if key == "up" or key == "w" and not (mapControl:isColliderInside(x,y - 1) == 'x' or mapControl:isColliderInside(x,y) == 'x1') then y = y - 1 playerControl:setSprite("spriteUp")  end
        if key == "down" or key == "s" and not (mapControl:isColliderInside(x,y + 1) == 'x' or mapControl:isColliderInside(x,y) == 'x1') then  y = y + 1 playerControl:setSprite("spriteDown") end

        -- Collision with the Walls
        if  not (mapControl:isColliderInside(x,y) == 'x' or mapControl:isColliderInside(x,y) == 'x1') then
            playerControl:setPx(x)
            playerControl:setPy(y)
        end

        -- Collision with the Chest
        if mapControl:isColliderInside(x,y) == 'c' then
            math.randomseed(os.clock())
            local numSort = 0
            numSort = math.random(100)
            
            if numSort >= 0 and numSort < 43 then numSort = 1
                elseif numSort >= 43 and numSort < 86 then numSort = 2
                elseif numSort >= 86 and numSort <= 100 then numSort = 3
            end
            
            if numSort == 1 then itemChest = allItens:getRandomSword(mapControl:getMapLevel()) elseif numSort == 2 then itemChest = allItens:getRandomArmor(mapControl:getMapLevel()) else itemChest = allItens:getPotion() end
            mapControl:getMap()[y][x] = 'f'
            state = "chest"
        end
        
        -- Collision with the Stairs
        if mapControl:isColliderInside(x,y) == 's' then
            mapControl = arrayMaps[mapControl:getMapLevel()+1]
            love.window.setTitle(mapControl:getNameMap())
            playerControl:setPx(2)
            playerControl:setPy(2)
            clearFog()
            state = "move"
            itemChest = nil
        end

    end

    -- State Died
    if state == "died" then
        if key == "q" then love.event.quit() end
        if key == "r" then love.event.quit( "restart" ) end
    end

    if mapControl:isCollider(x,y,'m') then state = "battle"
        elseif mapControl:isCollider(x,y,'m1') then state = "battle"
        elseif mapControl:isCollider(x,y,'m2') then state = "battle"
        elseif mapControl:isCollider(x,y,'m3') then state = "battle" 
    end

    -- State Chest
    if state == "chest" then
        if key == "e" then if itemChest.type == "sword" then playerControl:setEquipSword(itemChest) elseif itemChest.type == "armor" then playerControl:setEquipArmor(itemChest) else playerControl:setInventoryPotion(1) end state = "move" end
        if key == "q" then state = "move" end
    end

end

------- [ Function start the battle ] -------
function activeBattle()
    for key,i in pairs(arrayMonsterName) do
        if not (mapControl:getMonsterTile(playerControl:getPy(),playerControl:getPx(),i) == false) then
            My,Mx,typeMonster = mapControl:getMonsterTile(playerControl:getPy(),playerControl:getPx(),i)
        end
    end
    currentMonster = copy1(arrayMonster[typeMonster])
end

function tryToRun()
    for key,i in pairs(arrayMonsterName) do
        if not (mapControl:getMonsterTile(playerControl:getPy(),playerControl:getPx(),i) == false) then
            My,Mx,typeMonster = mapControl:getMonsterTile(playerControl:getPy(),playerControl:getPx(),i)
        end
    end
    mapControl:getMap()[My][Mx] = 'f'
end

------- [ Function copy the objects ] -------
function copy1(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {}
    for k, v in pairs(obj) do res[copy1(k)] = copy1(v) end
    return res
end

------- [ Function verify accuracy player ] -------
function isHitPlayer()
    if (math.random(currentMonster.dexterity) <= playerControl:getAccuracy()+playerControl:getAccuracySword()) then return true end
    return false
end

------- [ Function verify accuracy monster ] -------
function isHitMonster()
    if (math.random(playerControl:getDexterity()+playerControl:getDexterityArmor()) <= currentMonster.accuracy) then return true end
    return false
end

------- [ Function loot of the monster ] -------
function lootMonster()
    local tmp = false
    if not(currentMonster == nil) then
        tmp = playerControl:setXP(currentMonster.expWin)
    end
    isLevelUpdate = tmp
    baseLifePlayer = playerControl:getMaxLife()
end