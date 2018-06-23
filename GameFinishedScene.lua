local composer = require( "composer" )

local scene = composer.newScene()
local sceneGroup = nil

local winSymbol = nil
local wonImage = nil
local winMusic = audio.loadSound("assets/win.ogg")
local noWinMusic = audio.loadSound("assets/nowin.ogg")
local clickMusic = audio.loadSound("assets/main_menu/click.ogg")


local function ResetScene()
    winSymbol = nil
    wonImage = nil
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
    ResetScene()
    local _sceneGroup = self.view
    sceneGroup = _sceneGroup

    -- Code here runs when the scene is first created but has not yet appeared on screen
    if event.params ~= nil then
        winSymbol = event.params.winSymbol
    end
    
    if winSymbol ~= nil then
        print("GameFinishedScene winSymbol " .. winSymbol)
    else
        print ("GameFinishedScene winSymbol nil")
    end

end

function playAgainTap(event)
    if ( event.phase == "ended" ) then 
        audio.stop()
        composer.gotoScene("GameScene", { params = { gameMode = "easy" }, effect = "zoomInOutFade"})
    end
end
 

function backToMainMenuTap(event)
    if ( event.phase == "ended" ) then 
        audio.stop()
        composer.gotoScene("MainMenuScene", { effect = "zoomInOutFade"})
    end
end

function displayButtons()
    
    local restartIcon = display.newImageRect("assets/play_again_icon.png", 100, 100)
    restartIcon.anchorX = 0
    restartIcon.anchorY = 0
    restartIcon.x = 750
    restartIcon.y = 500

    sceneGroup:insert(restartIcon)

    restartIcon:addEventListener("touch", playAgainTap)


    local backtoMenuIcon = display.newImageRect("assets/back_main_menu.png", 100, 100)
    backtoMenuIcon.anchorX = 0
    backtoMenuIcon.anchorY = 0
    backtoMenuIcon.x = 750
    backtoMenuIcon.y = 650

    sceneGroup:insert(backtoMenuIcon)

    backtoMenuIcon:addEventListener("touch", backToMainMenuTap)
end


-- show()
function scene:show( event )
 
    --local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        --GameLogic.StartGame(gameMode)

        -- audio.setVolume(musicVolume)
        print (winSymbol)
        if (winSymbol == 'X') then
            print ("x won")
            audio.play(winMusic)
            wonImage = display.newImageRect("assets/x_won.png", 900, 900)
            wonImage.anchorX = 0
            wonImage.anchorY = 0
            wonImage.x = 0
            wonImage.y = 0

            sceneGroup:insert(wonImage)
            displayButtons()
        elseif (winSymbol == 'O') then
            print ("o won")
            audio.play(noWinMusic)
            wonImage = display.newImageRect("assets/o_won.png", 900, 900)
            wonImage.anchorX = 0
            wonImage.anchorY = 0
            wonImage.x = 0
            wonImage.y = 0

            sceneGroup:insert(wonImage)
            displayButtons()
        else
            print ("no win")
            wonImage = display.newImageRect("assets/no_win.png", 800, 300)
            wonImage.anchorX = 0
            wonImage.anchorY = 0
            wonImage.x = 0
            wonImage.y = 0

            audio.play(noWinMusic)
         
            sceneGroup:insert(wonImage)
            displayButtons()
        end
        
        
    end
end
 
 
-- hide()
function scene:hide( event )
 
    --local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        if wonImage ~= nil then 
            wonImage:removeSelf()
        end
    end
end
 
-- destroy()
function scene:destroy( event )
 
    --local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end
 

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene