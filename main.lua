-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local gridMatrix = {}
local gameEnded = false
local currentPlayerSymbol = "X"

local background = display.newImageRect("assets/background.jpg", 900, 900)
background.anchorX = 0
background.anchorY = 0

local grid = display.newImageRect("assets/grid.png", 900, 900)
grid.anchorX = 0
grid.anchorY = 0

local backgroundMusic = audio.loadSound("assets/music.ogg")
local tadaMusic = audio.loadSound("assets/tada.mp3")

local musicVolume = 0.5
local musicPlaying = true

audio.setVolume(musicVolume)
audio.play(backgroundMusic)

local function initGridMatrix()
    for i = 0, 2 do
        gridMatrix[i] = {}

        for j = 0, 2 do
            gridMatrix[i][j] = nil
        end
    end
end

-- top left diagonal check
local function WinCheck1()
    local result = gridMatrix[0][0] ~= nil and
    gridMatrix[1][1] == gridMatrix[0][0] and
    gridMatrix[2][2] == gridMatrix[0][0]

    return result
        
end

-- bottom left diagonal check
local function WinCheck2()
    return gridMatrix[2][0] ~= nil and
        gridMatrix[1][1] == gridMatrix[2][0] and
        gridMatrix[0][2] == gridMatrix[2][0]
end

-- first column check
local function WinCheck3()
    return
        gridMatrix[0][0] ~= nil and
        gridMatrix[1][0] == gridMatrix[0][0] and
        gridMatrix[2][0] == gridMatrix[0][0]
end

-- second column check
local function WinCheck4()
    return 
        gridMatrix[0][1] ~= nil and
        gridMatrix[1][1] == gridMatrix[0][1] and
        gridMatrix[2][1] == gridMatrix[0][1]
end

-- third column check
local function WinCheck5()
    return
        gridMatrix[0][2] ~= nil and
        gridMatrix[1][2] == gridMatrix[0][2] and
        gridMatrix[2][2] == gridMatrix[0][2]
end

-- first row check
local function WinCheck6()
    return
        gridMatrix[0][0] ~= nil and
        gridMatrix[0][1] == gridMatrix[0][0] and
        gridMatrix[0][2] == gridMatrix[0][0]
end

-- second row check
local function WinCheck7()
    return
        gridMatrix[1][0] ~= nil and
        gridMatrix[1][1] == gridMatrix[1][0] and
        gridMatrix[1][2] == gridMatrix[1][0]
end

-- third row check
local function WinCheck8()
    return
        gridMatrix[2][0] ~= nil and
        gridMatrix[2][1] == gridMatrix[2][0] and
        gridMatrix[2][2] == gridMatrix[2][0]
end

local function tapListener(event)

    -- if game ended then we don't want any player to continue playing
    if (gameEnded) then
        return true
    end

    if (event.phase == "ended") then
        -- FIRST ROW

        if (event.x > 0 and event.x < 300 and event.y > 0 and event.y < 300) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 10
            playerSymbol.y = 10

            gridMatrix[0][0] = currentPlayerSymbol
        end
        
        if (event.x > 300 and event.x < 600 and event.y > 0 and event.y < 300) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 310
            playerSymbol.y = 10

            gridMatrix[0][1] = currentPlayerSymbol
        end

        if (event.x > 600 and event.x < 900 and event.y > 150 and event.y < 300) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 610
            playerSymbol.y = 10

            gridMatrix[0][2] = currentPlayerSymbol
        end

        --- SECOND ROW

        if (event.x > 0 and event.x < 300 and event.y > 300 and event.y < 600) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 10
            playerSymbol.y = 310

            gridMatrix[1][0] = currentPlayerSymbol
        end
        
        if (event.x > 300 and event.x < 600 and event.y > 300 and event.y < 600) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 310
            playerSymbol.y = 310

            gridMatrix[1][1] = currentPlayerSymbol
        end

        if (event.x > 600 and event.x < 900 and event.y > 300 and event.y < 600) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 610
            playerSymbol.y = 310

            gridMatrix[1][2] = currentPlayerSymbol
        end

        --- THIRD ROW

        if (event.x > 0 and event.x < 300 and event.y > 600 and event.y < 900) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 10
            playerSymbol.y = 610

            gridMatrix[2][0] = currentPlayerSymbol
        end
        
        if (event.x > 300 and event.x < 600 and event.y > 600 and event.y < 900) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 310
            playerSymbol.y = 610

            gridMatrix[2][1] = currentPlayerSymbol
        end

        if (event.x > 600 and event.x < 900 and event.y > 600 and event.y < 900) then    
            local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
            playerSymbol.anchorX = 0
            playerSymbol.anchorY = 0
            playerSymbol.x = 610
            playerSymbol.y = 610
            
            gridMatrix[2][2] = currentPlayerSymbol
        end

        

        if (WinCheck1() or WinCheck2() or WinCheck3() or WinCheck4() or WinCheck5()
            or WinCheck6() or WinCheck7() or WinCheck8()) then
              print (" a win!")
              gameEnded = true
           
              audio.setVolume(musicVolume)
              audio.play(tadaMusic)

               local winText = display.newText( currentPlayerSymbol .. " has won!", 
               display.contentCenterX, display.contentCenterY, 
               native.systemFont, 106 )
               winText:setFillColor( 0, 0, 1 )
        else
            -- switch player 
            if (currentPlayerSymbol == "X") then
                currentPlayerSymbol = "O"
            else
                currentPlayerSymbol = "X"
            end
        end

        
    end
    
    return true
end

local function keyboardListener(event)
    if (event.phase == "down") then
        if (event.keyName == "m") then
            
            if (musicPlaying) then
                musicPlaying = false
                audio.setVolume(0)
            else
                musicPlaying = true
                audio.setVolume(musicVolume)
            end
            
        end
    end
end

initGridMatrix()

background:addEventListener("touch", tapListener)
Runtime:addEventListener( "key",keyboardListener )