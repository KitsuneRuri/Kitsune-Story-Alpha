--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/02/2019
	
    -- HelpMenuState Class --
	
	A class to pop up a help window detailing the game's controls. It will automatically appear
	when a new game is started, and afterwards can be accessed through the menu screen.
]]

HelpMenuState = Class{__includes = BaseState}

function HelpMenuState:init()
	self.helpMenu = Menu {
        x = 32,
        y = 16,
        width = VIRTUAL_WIDTH - 64,
        height = VIRTUAL_HEIGHT - 32,
		displayCursor = false,
        items = {
			{
				text = '         Game Controls',
                onSelect = function()
                    gStateStack:pop()
                end
			},
			{
				text = 'Key        Field                  Menu',
                onSelect = function()
                    gStateStack:pop()
                end
			},
			{
				text = 'Arrows    Move (Left/Right)    Select (Up/Down)',
                onSelect = function()
                    gStateStack:pop()
                end
			},
			{
				text = 'Z          Jump                  Confirm',
                onSelect = function()
                    gStateStack:pop()
                end
			},
			{
				text = 'X          Sword Slash          Cancel',
                onSelect = function()
                    gStateStack:pop()
                end
			},
			{
				text = 'C          Cast Selected Magic   [N/A]',
                onSelect = function()
                    gStateStack:pop()
                end
			},
			{
				text = 'Spacebar  Open Menu            Close Menu',
                onSelect = function()
                    gStateStack:pop()
                end
			}
		}
	}
end

function HelpMenuState:update(dt)
	self.helpMenu:update(dt)
	
	if love.keyboard.wasPressed('x') or love.keyboard.wasPressed('space') then
		gSounds['cancel']:play()
		
		gStateStack:pop()
	end
end

function HelpMenuState:render()
	self.helpMenu:render()
end