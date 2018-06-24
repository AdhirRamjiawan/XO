local GameStatsModule = {}

local FILE_PATH = nil
local file = nil
local errorString = nil

function init(fileAccessMode)
    file, errorString = io.open(FILE_PATH, fileAccessMode)
    FILE_PATH = system.pathForFile("gamestats.dat", system.DocumentsDirectory)
end

function cleanup()
    file = nil
    io.close(file)
end

GameStatsModule.GetStats = function()
    init("w")

    if not file then
        print("File error: " .. errorString)
        GameStatsModule.SaveStats("")
    end
    local contents = file:read( "*a" )
    cleanup()

    local easyPart = string.sub(contents, 1, string.find(contents, "|") -1)
    local hardPart = string.sub(contents, string.find(contents, "|") + 1, string.len(contents))
    
    local playerEasyScore = string.sub(easyPart, 1, string.find(easyPart, ";") -1)
    local cpuEasyScore = string.sub(easyPart, string.find(easyPart, ";") + 1, string.len(easyPart))
    
    local playerHardScore = string.sub(hardPart, 1, string.find(hardPart, ";") -1)
    local cpuHardScore = string.sub(hardPart, string.find(hardPart, ";") + 1, string.len(hardPart))
    

    return {
        Easy = {
            PlayerScore = playerEasyScore,
            CPUScore = cpuEasyScore
        },
        Hard {
            PlayerScore = playerHardScore,
            CPUScore = cpuHardScore
        }
    }
    
end

GameStatsModule.SaveAllStats = function(data)
    init("r")
    local strData = data.Easy.PlayerScore .. ";" data.Easy.CPUScore .. "|" ..data.Hard.PlayerScore .. ";" data.Hard.CPUScore
    file:write(strData)
    cleanup()
end

GameStatsModule.SaveEasyStats = function(data)
    init("r")
    local allStats = GameStatsModule.GetStats()
    data.Hard = allStats.Hard
    local strData = data.Easy.PlayerScore .. ";" data.Easy.CPUScore .. "|" ..data.Hard.PlayerScore .. ";" data.Hard.CPUScore
    file:write(strData)
    cleanup()
end

GameStatsModule.SaveHardStats = function(data)
    init("r")
    local allStats = GameStatsModule.GetStats()
    data.Easy = allStats.Easy
    local strData = data.Easy.PlayerScore .. ";" data.Easy.CPUScore .. "|" ..data.Hard.PlayerScore .. ";" data.Hard.CPUScore
    file:write(strData)
    cleanup()
end

return GameStatsModule