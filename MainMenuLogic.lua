local composer = require("composer")

local MainMenuLogicModule = {}

local background = nil
local logo = nil
local button_easy = nil
local button_hard = nil
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

local function tapListener(event)

    print ("click")
 
    if (event.phase == "ended") then

        if (event.x >= 250 and event.x <= 650 and event.y >= 400 and event.y <= 600) then
            audio.stop(1)
            composer.gotoScene("GameScene")
        end

    end
    return true
end

function MainMenuLogicModule.CreateMainMenu()
   
    background = display.newImageRect("assets/background.jpg", 900, 900)
    background.anchorX = 0
    background.anchorY = 0

    logo = display.newImageRect("assets/main_menu/logo.png", 600, 200)
    logo.anchorX = 0
    logo.anchorY = 0
    logo.x = 150
    logo.y = 50

    button_easy = display.newImageRect("assets/main_menu/button_easy.png", 400, 200)
    button_easy.anchorX = 0
    button_easy.anchorY = 0
    button_easy.x = 250
    button_easy.y = 400

    button_hard = display.newImageRect("assets/main_menu/button_hard.png", 400, 200)
    button_hard.anchorX = 0
    button_hard.anchorY = 0
    button_hard.x = 250
    button_hard.y = 650

    background:addEventListener("touch", tapListener)
    Runtime:addEventListener("key", keyboardListener)
    --Runtime:addEventListener("enterFrame", onFrame)
end

return MainMenuLogicModule