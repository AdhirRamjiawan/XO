-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local gridMatrix = {}
local gameEnded = false
local currentPlayerSymbol = "X"
local currentPlayerMoveEnded = true
local displayAssets = {}
local displayAssetsIndex = 0
local cpuTurn = false

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
 {  0, 300,   0, 300, 0, 0,  10,  10},
 {300, 600,   0, 300, 0, 1, 310,  10},
 {600, 900, 150, 300, 0, 2, 610,  10},
 {  0, 300, 350, 600, 1, 0,  10, 310},
 {300, 600, 300, 600, 1, 1, 310, 310},
 {600, 900, 300, 600, 1, 2, 610, 310},
 {  0, 300, 600, 900, 2, 0,  10, 610},
 {300, 600, 600, 900, 2, 1, 310, 610},
 {600, 900, 600, 900, 2, 2, 610, 610}}

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

    --print("no play available check")

    for i = 0, 2 do
        for j = 0, 2 do
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
    end

    if (currentPlayerSymbol == 'X') then
        currentPlayerSymbol = 'O'
    else
        currentPlayerSymbol = 'X'
    end
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


local function cpuPlayEasy()

    local emptySlots = {}
    local emptySlotsIndex = 0

    for i = 0, 2 do
        for j = 0, 2 do
            if (gridMatrix[i][j] == nil) then
                emptySlots[emptySlotsIndex] = {}
                emptySlots[emptySlotsIndex][0] = i
                emptySlots[emptySlotsIndex][1] = j

                --print(emptySlots[emptySlotsIndex][0] .. ';' .. emptySlots[emptySlotsIndex][1])

                emptySlotsIndex = emptySlotsIndex + 1
            end 
        end
     end

     
    local randIndex = 0
    
    if (emptySlotsIndex - 1 > 0) then
        randIndex = math.random(emptySlotsIndex - 1) - 1
    end
    
    if (emptySlots[randIndex] == nil) then
        print ('randIndex is nil, returning')
        return true
    end

    local x = emptySlots[randIndex][0]
    local y = emptySlots[randIndex][1]

    print ('local x: ' .. x .. ', y: ' .. y .. '. # of emptySlots: ' .. #emptySlots + 1)

    --if (gridMatrix[x][y] == nil) then
        local gridLookupInfoX = (x * 3) + y + 1
        print ("gridLookupInfoX: " .. gridLookupInfoX)
        handlePlayerMove('O',nil,
            gridLookupInfo[gridLookupInfoX][1],
            gridLookupInfo[gridLookupInfoX][2],
            gridLookupInfo[gridLookupInfoX][3],
            gridLookupInfo[gridLookupInfoX][4],
            gridLookupInfo[gridLookupInfoX][5],
            gridLookupInfo[gridLookupInfoX][6],
            gridLookupInfo[gridLookupInfoX][7],
            gridLookupInfo[gridLookupInfoX][8]
        )
    --end

end

local function tapListener(event)

    print ("click")
    --print ("currentPlayerMoveEnded: ")
    --print (currentPlayerMoveEnded)
   -- print ("gameEnded")
    --print (gameEnded)

    if (gameEnded) then
        return true
    end

    if (event.phase == "ended") then

        if (currentPlayerMoveEnded == true) then
            
            --                    event,  X1,  X2,  Y1,  Y2,GX,GY,  PX,  PY
            r1 = handlePlayerMove('X', event,   0, 300,   0, 300, 0, 0,  10,  10)
            r2 = handlePlayerMove('X', event, 300, 600,   0, 300, 0, 1, 310,  10)
            r3 = handlePlayerMove('X', event, 600, 900, 150, 300, 0, 2, 610,  10)
            r4 = handlePlayerMove('X', event,   0, 300, 350, 600, 1, 0,  10, 310)
            r5 = handlePlayerMove('X', event, 300, 600, 300, 600, 1, 1, 310, 310)
            r6 = handlePlayerMove('X', event, 600, 900, 300, 600, 1, 2, 610, 310)
            r7 = handlePlayerMove('X', event,   0, 300, 600, 900, 2, 0,  10, 610)
            r8 = handlePlayerMove('X', event, 300, 600, 600, 900, 2, 1, 310, 610)
            r9 = handlePlayerMove('X', event, 600, 900, 600, 900, 2, 2, 610, 610)

            -- just ensuring that there was a valid player move before attempting CPU move and win check
            if (r1 or r2 or r3 or r4 or r5 or r6 or r7 or r8 or r9) then
                cpuPlayEasy()
                handleWinCheckScenarios()
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

ResetGame()

background:addEventListener("touch", tapListener)
Runtime:addEventListener("key", keyboardListener)
Runtime:addEventListener("enterFrame", onFrame)