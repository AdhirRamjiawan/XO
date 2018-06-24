

local statsData = "2;3|1;24"
local easyPart = string.sub(statsData, 1, string.find(statsData, "|") -1)
local hardPart = string.sub(statsData, string.find(statsData, "|") + 1, string.len(statsData))

local playerEasyScore = string.sub(easyPart, 1, string.find(easyPart, ";") -1)
local cpuEasyScore = string.sub(easyPart, string.find(easyPart, ";") + 1, string.len(easyPart))

local playerHardScore = string.sub(hardPart, 1, string.find(hardPart, ";") -1)
local cpuHardScore = string.sub(hardPart, string.find(hardPart, ";") + 1, string.len(hardPart))

print (easyPart)
print (hardPart)

print("easy: player " .. playerEasyScore .. ", cpu " .. cpuEasyScore)
print("hard: player " .. playerHardScore .. ", cpu " .. cpuHardScore)

--local statsEasy

-- for i in gameModeParts do
--     print (i)
-- end