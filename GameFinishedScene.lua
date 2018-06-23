local composer = require( "composer" )

local scene = composer.newScene()

local winSymbol = nil
local wonImage = nil

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    winSymbol = event.params.winSymbol
end
 
function close_tap(event)
    wonImage:removeSelf()
    wonImage = nil
    composer.hideOverlay( "fade", 100 )
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        --GameLogic.StartGame(gameMode)

        -- audio.setVolume(musicVolume)

        -- if (winSymbol == 'X') then
        --     audio.play(winMusic)
        -- else
        --     audio.play(noWinMusic)
        -- end

        --local wonImage = display.newImageRect("assets/".. winSymbol .."_has_won.png", 800, 300)
        wonImage = display.newImageRect("assets/X_has_won.png", 800, 300)
        wonImage.anchorX = 0
        wonImage.anchorY = 0
        wonImage.x = 50
        wonImage.y = display.contentCenterY

        wonImage:addEventListener("touch", close_tap)
        
        
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        parent:resumeGame()
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
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