--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
    -- VictoryState Class --

    The victory screen that displays when the player has beaten game level 3.
]]

VictoryState = Class{__includes = BaseState}

function VictoryState:init()
	-- gSounds['boss-theme']:stop()
	-- gSounds['victory']:play()
end

function VictoryState:update(dt)
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

function VictoryState:render()
    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(192, 192, 64, 255)
    love.graphics.printf('Congratulations!', 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('YOU WON!', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')
end