local MainMenuLogicModule = {}

local background = nil
local backgroundMusic = audio.loadSound("assets/music.ogg")

local musicVolume = 0.5
local musicPlaying = true

audio.setVolume(musicVolume)
audio.play(backgroundMusic)

local function getTime()
    local time = os.date('*t')
    local seconds = os.time(time)
    return seconds
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

    end
end

function MainMenuLogicModule.CreateMainMenu()
   
    background = display.newImageRect("assets/background.jpg", 900, 900)
    background.anchorX = 0
    background.anchorY = 0

    --background:addEventListener("touch", tapListener)
    Runtime:addEventListener("key", keyboardListener)
    --Runtime:addEventListener("enterFrame", onFrame)
end

return MainMenuLogicModule