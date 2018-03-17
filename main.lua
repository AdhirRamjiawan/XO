-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local currentPlayerSymbol = "X"

local background = display.newImageRect("assets/space1.jpg", 900, 900)
background.anchorX = 0
background.anchorY = 0

local grid = display.newImageRect("assets/grid.png", 900, 900)
grid.anchorX = 0
grid.anchorY = 0

local backgroundMusic = audio.loadSound("assets/music.mp3")
audio.setVolume(0.5)
--audio.play(backgroundMusic)


local function tapListener(event)

    -- FIRST ROW

    if (event.x > 0 and event.x < 300 and event.y > 0 and event.y < 300) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 10
        playerSymbol.y = 10
    end
    
    if (event.x > 300 and event.x < 600 and event.y > 0 and event.y < 300) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 310
        playerSymbol.y = 10
    end

    if (event.x > 600 and event.x < 900 and event.y > 150 and event.y < 300) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 610
        playerSymbol.y = 10
    end

    --- SECOND ROW

    if (event.x > 0 and event.x < 300 and event.y > 300 and event.y < 600) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 10
        playerSymbol.y = 310
    end
    
    if (event.x > 300 and event.x < 600 and event.y > 300 and event.y < 600) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 310
        playerSymbol.y = 310
    end

    if (event.x > 600 and event.x < 900 and event.y > 300 and event.y < 600) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 610
        playerSymbol.y = 310
    end

     --- THIRD ROW

     if (event.x > 0 and event.x < 300 and event.y > 600 and event.y < 900) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 10
        playerSymbol.y = 610
    end
    
    if (event.x > 300 and event.x < 600 and event.y > 600 and event.y < 900) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 310
        playerSymbol.y = 610
    end

    if (event.x > 600 and event.x < 900 and event.y > 600 and event.y < 900) then    
        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = 610
        playerSymbol.y = 610
    end

    if (currentPlayerSymbol == "X") then
        currentPlayerSymbol = "O"
    else
        currentPlayerSymbol = "X"
    end

    return true
end

background:addEventListener("touch", tapListener)