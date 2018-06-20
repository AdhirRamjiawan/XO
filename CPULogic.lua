local CPULogicModule = {}

CPULogicModule.CPUPlayEasy = function(gridMatrix, gridLookupInfo, handlePlayerMove)
    local emptySlots = {}
    local emptySlotsIndex = 1

    for i = 1, 3 do
        for j = 1, 3 do
            if (gridMatrix[i][j] == nil) then
                emptySlots[emptySlotsIndex] = {}
                emptySlots[emptySlotsIndex][1] = i
                emptySlots[emptySlotsIndex][2] = j
                emptySlotsIndex = emptySlotsIndex + 1
            end
        end
     end
     
    local randIndex = 1
    
    if emptySlotsIndex == 1 then
        randIndex = math.random(emptySlotsIndex)
    else
        randIndex = math.random(emptySlotsIndex - 1)

        print(randIndex)

        local x = emptySlots[randIndex][1]
        local y = emptySlots[randIndex][2]

        local LuX = (x * 3) + y - 3
        print ("LuX: " .. LuX)
        handlePlayerMove('O',nil,
            gridLookupInfo[LuX][1],
            gridLookupInfo[LuX][2],
            gridLookupInfo[LuX][3],
            gridLookupInfo[LuX][4],
            gridLookupInfo[LuX][5],
            gridLookupInfo[LuX][6],
            gridLookupInfo[LuX][7],
            gridLookupInfo[LuX][8]
        )
    end
end

CPULogicModule.CPUPlayHard = function(gridMatrix, gridLookupInfo, handlePlayerMove)
    
    local LuX = 0
    local makeMove = false
    local tmpX = 0
    local tmpY = 0
    
    for i = 1, 3 do
        local currentWinPlacementCount = 0
        local emptySlot = nil
        local isYMove = false

        -- blocking moves going across one each row, left <-> right
        -- Row moves
        if (gridMatrix[i][1] == "X" and gridMatrix[i][3] == "X") then
            tmpX = 2
            makeMove = true
            isYMove = false
        elseif (gridMatrix[i][2] == "X" and gridMatrix[i][3] == "X") then
            tmpX = 1
            makeMove = true
            isYMove = false
        elseif (gridMatrix[i][1] == "X" and gridMatrix[i][2] == "X") then
            tmpX = 3
            makeMove = true
            isYMove = false
        -- Column moves
        elseif (gridMatrix[1][i] == "X" and gridMatrix[3][i] == "X") then
            tmpY = 2
            makeMove = true
            isYMove = true
        elseif (gridMatrix[2][i] == "X" and gridMatrix[3][i] == "X") then
            tmpY = 1
            makeMove = true
            isYMove = true
        elseif (gridMatrix[1][i] == "X" and gridMatrix[2][i] == "X") then
            tmpY = 3
            makeMove = true
            isYMove = true
        else
            makeMove = false
        end

        if (makeMove == true) then
            if (isYMove == false) then
                LuX = ((i * 3) + tmpX) -3 -- gets correct lookup
            else
                LuX = ((tmpY * 3) + i) -3 -- gets correct lookup
            end

            handlePlayerMove('O',nil,
                    gridLookupInfo[LuX][1],
                    gridLookupInfo[LuX][2],
                    gridLookupInfo[LuX][3],
                    gridLookupInfo[LuX][4],
                    gridLookupInfo[LuX][5], -- x
                    gridLookupInfo[LuX][6], -- y
                    gridLookupInfo[LuX][7],
                    gridLookupInfo[LuX][8]
                )
        end

    end

        -- diagonal moves
        if (gridMatrix[1][1] == "X" and gridMatrix[2][2] == "X") then
            tmpX = 3
            tmpY = 3
            makeMove = true
            print ("tmpX " ..tmpX)
        print ("tmpY " ..tmpY)
        elseif (gridMatrix[1][3] == "X" and gridMatrix[2][2] == "X") then
            tmpX = 1
            tmpY = 3
            makeMove = true
            print ("tmpX " ..tmpX)
        print ("tmpY " ..tmpY)
        elseif (gridMatrix[3][1] == "X" and gridMatrix[2][2] == "X") then
            tmpX = 3
            tmpY = 1
            makeMove = true
            print ("tmpX " ..tmpX)
        print ("tmpY " ..tmpY)
        elseif (gridMatrix[3][3] == "X" and gridMatrix[2][2] == "X") then
            tmpX = 1
            tmpY = 1
            makeMove = true
            print ("tmpX " ..tmpX)
        print ("tmpY " ..tmpY)
        end

    

    if (makeMove == true) then
        if tmpY == 0 then tmpY = 1 end
        if tmpX == 0 then tmpX = 1 end

        LuX = ((tmpY * 3) + tmpX) -3 -- gets correct lookup
        
        print (LuX)
        
        handlePlayerMove('O',nil,
                    gridLookupInfo[LuX][1],
                    gridLookupInfo[LuX][2],
                    gridLookupInfo[LuX][3],
                    gridLookupInfo[LuX][4],
                    gridLookupInfo[LuX][5], -- x
                    gridLookupInfo[LuX][6], -- y
                    gridLookupInfo[LuX][7],
                    gridLookupInfo[LuX][8]
                )
    end

    -- if (makeMove == false) then
    --     print("finding an easy CPU play!")
    --     cpuPlayEasy()
    -- end
end

return CPULogicModule