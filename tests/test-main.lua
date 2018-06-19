

local grid = {}

grid[1] = {"X", "O", "O"}
grid[2] = {"X", "X", nil}
grid[3] = {"X", nil, nil}

local function makeMoveList(_grid)
    local moveList = {}
    local globalCount = 1

    -- each row
    for count = 1, 3 do
        moveList[globalCount] = _grid[count]
        globalCount = globalCount + 1
    end

    -- each column
    for count = 1, 3 do
        moveList[globalCount] = {}
        
        for count2 = 1, 3 do
            moveList[globalCount][count2] = _grid[count2][count]
        end
        
        globalCount = globalCount + 1
    end

    -- diagonals
    moveList[globalCount] = {_grid[1][1], _grid[2][2], _grid[3][3]}
    
    globalCount = globalCount + 1

    moveList[globalCount] = {_grid[1][3], _grid[2][2], _grid[3][1]}

    return moveList
end

local moveList = makeMoveList(grid)

local function displayMoveList(_moveList)
    
    for i = 1, #_moveList do
        local str = ""

        for j = 1, 3 do
            if _moveList[i][j] ~= nil then
                str = str .. "," .. _moveList[i][j]
            else
                str = str .. ",nil"
            end
        end

        print(str)
    end
end

displayMoveList(moveList)

local function checkWinsOnMoveList(_moveList)
    local winSymbol = nil

    for i =1, #_moveList  do
        if winSymbol == nil then
            local xCount = 0
            local oCount = 0

            for j =1, 3 do
                if _moveList[i][j] == "X" then
                    xCount = xCount + 1
                elseif  _moveList[i][j] == "O" then
                    oCount = oCount + 1
                end

            end

            -- print('xCount : ' .. xCount)
            -- print('oCount : ' .. oCount)
            -- print(' --- ')

            if (xCount == 3) then
                winSymbol = "X"
            elseif (oCount == 3) then
                winSymbol = "O"
            end
        end
    end

    return winSymbol
end

--local result = checkWinsOnMoveList(moveList)

print ("winner is: ")
print (result)