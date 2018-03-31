-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local gridMatrix = {}
local gameEnded = false
local currentPlayerSymbol = "X"
local displayAssets = {}
local displayAssetsIndex = 0

local time = os.date('*t')
local timeFromWin = os.time(time)
local gameEndedTime = os.time(time)
local background = nil
local grid = nil

local backgroundMusic = audio.loadSound("assets/music.ogg")
local tadaMusic = audio.loadSound("assets/tada.mp3")

local musicVolume = 0.5
local musicPlaying = true

audio.setVolume(musicVolume)
audio.play(backgroundMusic)

local function getTime()
    local time = os.date('*t')
    local seconds = os.time(time)
    return seconds
end

local function initGridMatrix()
    gridMatrix = {}
    for i = 0, 2 do
        gridMatrix[i] = {}

        for j = 0, 2 do
            gridMatrix[i][j] = nil
        end
    end
end

local function noPlayAvailable()

    print("no play available check")

    for i = 0, 2 do
        for j = 0, 2 do
            if (gridMatrix[i][j] == nil) then
                print("no play available!")
                return false
            end
        end
    end

    return true
end

local function ResetGame()
    initGridMatrix()
    currentPlayerSymbol = "X"
    gameEnded = false

    if (displayAssetsIndex > 0) then
        for i = 0, displayAssetsIndex do
           if (displayAssets[i] ~= nil) then
                displayAssets[i]:removeSelf()
               displayAssets[i] = nil
           end
        end
    end
    
    displayAssetsIndex = 0

    displayAssets = {}

    if (background == nil) then
        background = display.newImageRect("assets/background.jpg", 900, 900)
        background.anchorX = 0
        background.anchorY = 0
    end

    if (grid == nil) then
        grid = display.newImageRect("assets/grid.png", 900, 900)
        grid.anchorX = 0
        grid.anchorY = 0
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


local function handleWinCheckScenarios()
    if (WinCheck1() or WinCheck2() or WinCheck3() or WinCheck4() or WinCheck5()
        or WinCheck6() or WinCheck7() or WinCheck8()) then
            print (" a win!")
            gameEnded = true
            gameEndedTime = getTime()

            --background.fill.effect = "filter.crosshatch"

            audio.setVolume(musicVolume)
            audio.play(tadaMusic)

            local wonImage = display.newImageRect("assets/".. currentPlayerSymbol .."_has_won.png", 800, 300)
            wonImage.anchorX = 0
            wonImage.anchorY = 0
            wonImage.x = 50
            wonImage.y = display.contentCenterY
        
            displayAssets[displayAssetsIndex] = wonImage
            displayAssetsIndex = displayAssetsIndex + 1

            timeFromWin = os.time(time)
    elseif (noPlayAvailable()) then
        gameEnded = true
        gameEndedTime = getTime()

        local noWinImage = display.newImageRect("assets/no_win.png", 800, 300)
        noWinImage.anchorX = 0
        noWinImage.anchorY = 0
        noWinImage.x = 50
        noWinImage.y = display.contentCenterY

        displayAssets[displayAssetsIndex] = noWinImage
        displayAssetsIndex = displayAssetsIndex + 1
    else
        -- switch player 
        if (currentPlayerSymbol == "X") then
            currentPlayerSymbol = "O"
        else
            currentPlayerSymbol = "X"
        end
    end
end

local function handlePlayerMove(event, x1, x2, y1, y2, gridMatrixX, gridMatrixY, symbolX, symbolY)
    if (event.x > x1 and event.x < x2 and event.y > y1 and event.y < y2) then 

        -- if grid element has a player marker then skip
        if (gridMatrix[gridMatrixX][gridMatrixY] ~= nil) then
            return true
        end

        local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
        playerSymbol.anchorX = 0
        playerSymbol.anchorY = 0
        playerSymbol.x = symbolX
        playerSymbol.y = symbolY

        displayAssets[displayAssetsIndex] = playerSymbol
        displayAssetsIndex = displayAssetsIndex + 1

        gridMatrix[gridMatrixX][gridMatrixY] = currentPlayerSymbol
    end
end

local function tapListener(event)

    if (gameEnded) then
        return true
    end

    if (event.phase == "ended") then
        
        handlePlayerMove(event,   0, 300,   0, 300, 0, 0,  10,  10)
        handlePlayerMove(event, 300, 600,   0, 300, 0, 1, 310,  10)
        handlePlayerMove(event, 600, 900, 150, 300, 0, 2, 610,  10)
        handlePlayerMove(event,   0, 300, 350, 600, 1, 0,  10, 310)
        handlePlayerMove(event, 300, 600, 300, 600, 1, 1, 310, 310)
        handlePlayerMove(event, 600, 900, 300, 600, 1, 2, 610, 310)
        handlePlayerMove(event,   0, 300, 600, 900, 2, 0,  10, 610)
        handlePlayerMove(event, 300, 600, 600, 900, 2, 1, 310, 610)
        handlePlayerMove(event, 600, 900, 600, 900, 2, 2, 610, 610)
    
        handleWinCheckScenarios()
        
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

        if (event.keyName == "r") then
            ResetGame()
        end
    end
end

local function onFrame(event)
    if (gameEnded and (getTime() - gameEndedTime) > 3) then
        ResetGame()
    end
end

ResetGame()

background:addEventListener("touch", tapListener)
Runtime:addEventListener("key", keyboardListener)
Runtime:addEventListener("enterFrame", onFrame)