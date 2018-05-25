local composer = require("composer")

local MainMenuLogicModule = {}

local background = nil
local logo = nil
local button_easy = nil
local button_hard = nil
local backgroundMusic = audio.loadSound("assets/main_menu/main_menu_music.ogg")
local clickMusic = audio.loadSound("assets/main_menu/click.ogg")

local logo_animation = nil
local button_easy_animation = nil

local gameSelected = false
local backgroundEffectsCounter = 0

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

-- sprite listener function
local function button_easy_spriteListener( event )

    local thisSprite = event.target  -- "event.target" references the sprite
    
    if ( event.phase == "ended" ) then 
        audio.stop(1)
        composer.gotoScene("GameScene")
    end
end

local function tapListener(event)

    print ("click")
 
    if (event.phase == "ended") then

        if (event.x >= 250 and event.x <= 650 and event.y >= 400 and event.y <= 600) then
            gameSelected = true

            audio.play(clickMusic)

            local button_easy_SheetOptions = 
            {
                width = 400,
                height = 200,
                numFrames = 6
            }

            local sheet_button_easy = graphics.newImageSheet("assets/main_menu/button_easy_sprite_sheet.png", button_easy_SheetOptions)
            local sequences_button_easy = {
                {
                    name = "button_easy_click",
                    frames = {1,2,3,4,5,6},
                    time = 600,
                    loopCount = 2,
                    loopDirection = "forward"
                }
            }

            button_easy:removeSelf()

            button_easy_animation = display.newSprite(sheet_button_easy, sequences_button_easy)
            button_easy_animation.anchorX = 0
            button_easy_animation.anchorY = 0
            button_easy_animation.x = 250
            button_easy_animation.y = 400
            
            button_easy_animation:addEventListener( "sprite", button_easy_spriteListener )

            button_easy_animation:setSequence("button_easy_click")
            button_easy_animation:play()
        end

    end
    return true
end

function setupLogoAnimation()
    local logo_SheetOptions = 
    {
        width = 600,
        height = 200,
        numFrames = 8
    }

    local sheet_logo = graphics.newImageSheet("assets/main_menu/logo_sprite_sheet.png", logo_SheetOptions)
    local sequences_logo_animation = {
        {
            name = "logo_sprite",
            frames = {1,2,3,4,5,6,7,8},
            time = 600,
            loopCount = 0,
            loopDirection = "forward"
        }
    }

    logo_animation = display.newSprite(sheet_logo, sequences_logo_animation)
    logo_animation.anchorX = 0
    logo_animation.anchorY = 0
    logo_animation.x = 150
    logo_animation.y = 50
    
    logo_animation:setSequence("button_easy_click")
    logo_animation:play()
end

local function onFrame(event)
    
    if (gameSelected and (backgroundEffectsCounter < 150)) then
        background.fill.effect = "filter.pixelate"
        background.fill.effect.numPixels = backgroundEffectsCounter

        backgroundEffectsCounter = backgroundEffectsCounter + 1
    end
end



function MainMenuLogicModule.CreateMainMenu()
    
    background = display.newImageRect("assets/background.jpg", 900, 900)
    background.anchorX = 0
    background.anchorY = 0

    --logo = display.newImageRect("assets/main_menu/logo.png", 600, 200)
    --logo.anchorX = 0
    --logo.anchorY = 0
    --logo.x = 150
    --logo.y = 50
    
    setupLogoAnimation()


    button_easy = display.newImageRect("assets/main_menu/button_easy.png", 400, 200)
    button_easy.anchorX = 0
    button_easy.anchorY = 0
    button_easy.x = 250
    button_easy.y = 400

   -- button_hard = display.newImageRect("assets/main_menu/button_hard.png", 400, 200)
    --button_hard.anchorX = 0
    --button_hard.anchorY = 0
    --button_hard.x = 250
    --button_hard.y = 650

    background:addEventListener("touch", tapListener)
    Runtime:addEventListener("key", keyboardListener)
    Runtime:addEventListener("enterFrame", onFrame)
end

return MainMenuLogicModule