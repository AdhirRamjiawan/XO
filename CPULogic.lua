local CPULogicModule = {}
local GameUtils = require("GameUtils")

local MOVELIST_GRIDLOOKUP_MAPPINGS = {
    {{1,1},{1,2},{1,3}},
    {{2,1},{2,2},{2,3}},
    {{3,1},{3,2},{3,3}},
    {{1,1},{2,1},{3,1}},
    {{1,2},{2,2},{3,2}},
    {{1,3},{2,3},{3,3}},
    {{1,1},{2,2},{3,3}},
    {{1,3},{2,2},{3,1}}
}


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
    local x = 0
    local y = 0

    local moveList = GameUtils.MakeMoveList(gridMatrix)

    for i = 1, #moveList do
        x = MOVELIST_GRIDLOOKUP_MAPPINGS[i][3][1]
        y = MOVELIST_GRIDLOOKUP_MAPPINGS[i][3][2]
        print ("x " .. x .. ", y " .. y)

        if moveList[i] == moveList[i + 1] and moveList[i] ==  "X" then
            
            LuX = (x * 3) + y - 3
        end
    end
    print ("Lux " .. LuX)
    
    if (LuX == 0) then
        print("finding an easy CPU play!")
        CPULogicModule.CPUPlayEasy(gridMatrix, gridLookupInfo, handlePlayerMove)
    else
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

return CPULogicModule