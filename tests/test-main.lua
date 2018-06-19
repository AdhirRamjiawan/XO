

local grid = {}

grid[1] = {"O", "X", "O"}
grid[2] = {"O", "O", "X"}
grid[3] = {"X", "X", "O"}

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
        local tmpCol = {}

        for count2 = 1, 3 do
            tmpCol[count2] = _grid[count][count2]
        end

        moveList[globalCount] = tmpCol
        globalCount = globalCount + 1
    end

    -- diagonals
    moveList[globalCount] = {_grid[1][1], _grid[2][2], _grid[3][3]}
    
    globalCount = globalCount + 1

    moveList[globalCount] = {_grid[1][3], _grid[2][2], _grid[3][1]}

    return moveList
end

local moveList = makeMoveList(grid)

local function checkWinsOnMoveList(_moveList)
    local winSymbol = nil

    for i =1, #moveList  do
        if winSymbol == nil then
            local xCount = 0
            local oCount = 0

            for j =1, 3 do
                if _moveList[i] ~= nil and _moveList[i][j] == "X" then
                    xCount = xCount + 1
                elseif _moveList[i] ~= nil and _moveList[i][j] == "O" then
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

local result = checkWinsOnMoveList(moveList)

print ("winner is: ")
print (result)