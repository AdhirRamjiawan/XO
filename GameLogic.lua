local CPULogic = require("CPULogic")
local GameUtils = require("GameUtils")

local GameLogicModule = {}

local gridMatrix = {}
local gameEnded = false
local currentPlayerSymbol = "X"
local currentPlayerMoveEnded = true
local displayAssets = {}
local displayAssetsIndex = 0
local cpuTurn = false
local gameMode = "easy"

local r1 = false
local r2 = false
local r3 = false
local r4 = false
local r5 = false
local r6 = false
local r7 = false
local r8 = false
local r9 = false

local gridLookupInfo = {
 {  0, 300,   0, 300, 1, 1,  10,  10},
 {300, 600,   0, 300, 1, 2, 310,  10},
 {600, 900, 150, 300, 1, 3, 610,  10},
 {  0, 300, 350, 600, 2, 1,  10, 310},
 {300, 600, 300, 600, 2, 2, 310, 310},
 {600, 900, 300, 600, 2, 3, 610, 310},
 {  0, 300, 600, 900, 3, 1,  10, 610},
 {300, 600, 600, 900, 3, 2, 310, 610},
 {600, 900, 600, 900, 3, 3, 610, 610}}

local time = os.date('*t')
local timeFromWin = os.time(time)
local gameEndedTime = os.time(time)
local background = nil
local grid = nil

local backgroundMusic = audio.loadSound("assets/music.ogg")
local winMusic = audio.loadSound("assets/win.ogg")
local noWinMusic = audio.loadSound("assets/nowin.ogg")
local clickMusic = audio.loadSound("assets/main_menu/click.ogg")

local musicVolume = 0.5
local musicPlaying = true

audio.setVolume(musicVolume)
audio.play(backgroundMusic, { loops = -1})

local function getTime()
    local time = os.date('*t')
    local seconds = os.time(time)
    return seconds
end

local function initGridMatrix()
    gridMatrix = {}
    gridMatrix[1] = {nil, nil, nil}
    gridMatrix[2] = {nil, nil, nil}
    gridMatrix[3] = {nil, nil, nil}
end

local function noPlayAvailable()

    --print("no play available check")

    for i = 1, 3 do
        for j = 1, 3 do
            if (gridMatrix[i][j] == nil) then
                
                return false
            end
        end
    end

   -- print("no play available!")

    return true
end

local function ResetGame()
    initGridMatrix()
    currentPlayerSymbol = "X"
    currentPlayerMoveEnded = true
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


local function handleWinCheckScenarios()
    local moveList = GameUtils.MakeMoveList(gridMatrix)
    local winSymbol = GameUtils.CheckWinsOnMoveList(moveList)

    -- if winSymbol ~= nil then
    --     print ("winsymbol " .. winSymbol)
    -- else
    --     print ("win symbol nil")
    -- end

    if winSymbol ~= nil then
            print (" a win!")
            gameEnded = true
            gameEndedTime = getTime()

            audio.setVolume(musicVolume)

            if (winSymbol == 'X') then
                audio.play(winMusic)
            else
                audio.play(noWinMusic)
            end

            local wonImage = display.newImageRect("assets/".. winSymbol .."_has_won.png", 800, 300)
            wonImage.anchorX = 0
            wonImage.anchorY = 0
            wonImage.x = 50
            wonImage.y = display.contentCenterY
        
            displayAssets[displayAssetsIndex] = wonImage
            displayAssetsIndex = displayAssetsIndex + 1

            timeFromWin = os.time(time)

            return true
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

        audio.play(noWinMusic)
    end
    return false
end


local function handlePlayerMove(currentPlayerSymbol, event, x1, x2, y1, y2, gridMatrixX, gridMatrixY, symbolX, symbolY)
    currentPlayerMoveEnded = false

    if (event ~= nil and not (event.x > x1 and event.x < x2 and event.y > y1 and event.y < y2)) then 
        currentPlayerMoveEnded = true
        return false
    end

    -- if grid element has a player marker then skip
    if (gridMatrix[gridMatrixX][gridMatrixY] ~= nil) then
        currentPlayerMoveEnded = true
        return false
    end

    local playerSymbol =  display.newImageRect("assets/" .. currentPlayerSymbol .. ".png", 290, 290)
    playerSymbol.anchorX = 0
    playerSymbol.anchorY = 0
    playerSymbol.x = symbolX
    playerSymbol.y = symbolY

    displayAssets[displayAssetsIndex] = playerSymbol
    displayAssetsIndex = displayAssetsIndex + 1

    gridMatrix[gridMatrixX][gridMatrixY] = currentPlayerSymbol
    cpuTurn = not cpuTurn

    currentPlayerMoveEnded = true

    return true
end


local function tapListener(event)

    if (gameEnded) then
        return true
    end

    if (event.phase == "ended") then

        if (currentPlayerMoveEnded == true) then
            audio.play(clickMusic)
            
            currentPlayerSymbol = 'X'

            print ("current play: " .. currentPlayerSymbol)
            --                    event,  X1,  X2,  Y1,  Y2,GX,GY,  PX,  PY
            r1 = handlePlayerMove('X', event,   0, 300,   0, 300, 1, 1,  10,  10)
            r2 = handlePlayerMove('X', event, 300, 600,   0, 300, 1, 2, 310,  10)
            r3 = handlePlayerMove('X', event, 600, 900, 150, 300, 1, 3, 610,  10)
            r4 = handlePlayerMove('X', event,   0, 300, 350, 600, 2, 1,  10, 310)
            r5 = handlePlayerMove('X', event, 300, 600, 300, 600, 2, 2, 310, 310)
            r6 = handlePlayerMove('X', event, 600, 900, 300, 600, 2, 3, 610, 310)
            r7 = handlePlayerMove('X', event,   0, 300, 600, 900, 3, 1,  10, 610)
            r8 = handlePlayerMove('X', event, 300, 600, 600, 900, 3, 2, 310, 610)
            r9 = handlePlayerMove('X', event, 600, 900, 600, 900, 3, 3, 610, 610)

            if (handleWinCheckScenarios() == false) then
                -- just ensuring that there was a valid player move before attempting CPU move and win check
                if (r1 or r2 or r3 or r4 or r5 or r6 or r7 or r8 or r9) then
                    
                    currentPlayerSymbol = 'O'
                    
                    if (gameMode == "easy") then
                        CPULogic.CPUPlayEasy(gridMatrix, gridLookupInfo, handlePlayerMove)
                    elseif (gameMode == "hard") then
                        CPULogic.CPUPlayHard(gridMatrix, gridLookupInfo, handlePlayerMove)
                    end

                    handleWinCheckScenarios()
                end
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

function GameLogicModule.StartGame(paramGameMode)

    print (paramGameMode)
    gameMode = paramGameMode
    ResetGame()

    background:addEventListener("touch", tapListener)
    Runtime:addEventListener("key", keyboardListener)
    Runtime:addEventListener("enterFrame", onFrame)
end

return GameLogicModule