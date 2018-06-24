local GameStatsModule = {}

local FILE_PATH = nil
local file = nil
local errorString = nil

function init(fileAccessMode)
    FILE_PATH = system.pathForFile("gamestats.dat", system.DocumentsDirectory)
    file, errorString = io.open(FILE_PATH, fileAccessMode)

    if errorString ~= nil then print(errorString) end
end

function cleanup()
    io.close(file)
    file = nil
end

function makeModel(epScore, ecScore, hpScore, chScore)
    local result = {}
    result.Easy = {}
    result.Hard = {}
    result.Easy.PlayerScore = epScore
    result.Easy.CPUScore = ecScore
    result.Hard.PlayerScore = hpScore
    result.Hard.CPUScore = chScore

    return result
end

function sanatiseScores(data)
    if data == nil then 
        data = makeModel(0,0,0,0) 
        return data
    end

    if data.Easy == nil then data.Easy = {}  end
    if data.Hard == nil then data.Hard = {}  end

    if data.Easy.PlayerScore     == nil then data.Easy.PlayerScore  = 0 end
    if data.Easy.CPUScore        == nil then data.Easy.CPUScore     = 0 end
    if data.Hard.PlayerScore     == nil then data.Hard.PlayerScore  = 0 end
    if data.Hard.CPUScore        == nil then data.Hard.CPUScore     = 0 end
    
    return data
end

GameStatsModule.SaveAllStats = function(data)
    if file == nil then init("w+") end

    data = sanatiseScores(data)
    local strData = data.Easy.PlayerScore .. ";" .. data.Easy.CPUScore .. "|" ..data.Hard.PlayerScore .. ";" .. data.Hard.CPUScore
    print(strData)
    file:write(strData)
    cleanup()
end


GameStatsModule.GetStats = function()
    if file == nil then init("w+") end

    if not file then
        print("File error: " .. errorString)
        GameStatsModule.SaveAllStats(makeModel(0,0,0,0))
    end

    local contents = file:read( "*a" )
    cleanup()

    if contents ~= nil then contents = string.gsub(contents, "%s+", "") end

    if contents ~= nil and contents ~= "" then
        print ("contents [" .. contents .. "]")
        print (contents == "")
        local easyPart = string.sub(contents, 1, string.find(contents, "|") -1)
        local hardPart = string.sub(contents, string.find(contents, "|") + 1, string.len(contents))
        
        local playerEasyScore = string.sub(easyPart, 1, string.find(easyPart, ";") -1)
        local cpuEasyScore = string.sub(easyPart, string.find(easyPart, ";") + 1, string.len(easyPart))
        
        local playerHardScore = string.sub(hardPart, 1, string.find(hardPart, ";") -1)
        local cpuHardScore = string.sub(hardPart, string.find(hardPart, ";") + 1, string.len(hardPart))
        

        return makeModel(playerEasyScore, cpuEasyScore, playerHardScore, cpuHardScore)
    else
        return makeModel(0,0,0,0)
    end
end


GameStatsModule.SaveEasyStats = function(data)
    if file == nil then init("w+") end

    data = sanatiseScores(data)
    local allStats = GameStatsModule.GetStats()
    data.Hard = allStats.Hard
    local strData = data.Easy.PlayerScore .. ";" .. data.Easy.CPUScore .. "|" ..data.Hard.PlayerScore .. ";" .. data.Hard.CPUScore
    print(strData)
    file:write(strData)
    cleanup()
end

GameStatsModule.SaveHardStats = function(data)
    if file == nil then init("w+") end

    data = sanatiseScores(data)
    local allStats = GameStatsModule.GetStats()
    data.Easy = allStats.Easy
    local strData = data.Easy.PlayerScore .. ";" .. data.Easy.CPUScore .. "|" ..data.Hard.PlayerScore .. ";" .. data.Hard.CPUScore
    print(strData)
    file:write(strData)
    cleanup()
end

return GameStatsModule