--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
    -- GameOverState Class --

    The game over screen that displays when the player's health bar is depleted.
	The actual "Game Over" display was copied from the assignement5 GameOverState.
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:init()
	-- stop both possible themes that could be playing
	gSounds['main-theme']:stop()
	gSounds['boss-theme']:stop()
	gSounds['game-over']:play()
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or
		love.keyboard.wasPressed('space') or love.keyboard.wasPressed('z') or love.keyboard.wasPressed('x') then
			gStateStack:push(FadeInState({
				r = 255, g = 255, b = 255
			}, 1,
			function()
				gStateStack:pop()
				
				gStateStack:push(StartState())
				gStateStack:push(FadeOutState({
					r = 255, g = 255, b = 255
				}, 1,
				function() end))
			end))
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(175, 53, 42, 255)
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 255, 255, 255)
end