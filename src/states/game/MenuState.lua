--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/10/2019
	
    -- MenuState Class --
]]

MenuState = Class{__includes = BaseState}

function MenuState:init(player)
	self.player = player
	
	self.menu = Menu {
        x = VIRTUAL_WIDTH - 160,
        y = 16,
        width = VIRTUAL_WIDTH / 4,
        height = VIRTUAL_HEIGHT / 2 - 32,
		displayCursor = true,
        items = {
			{
				text = 'Select Skill',
                onSelect = function()
                    gStateStack:push(CurrentSkillMenuState(self.player))
                    gStateStack:push(SelectSkillMenuState(self.player))
                end
			},
			{
				text = 'Learn Skill',
                onSelect = function()
                    gStateStack:push(CurrentSkillPointsMenuState(self.player))
					gStateStack:push(LearnSkillMenuState(self.player))
                end
			},
			{
				text = 'Skill Info',
                onSelect = function()
					gStateStack:push(SkillInfoMenuState(self.player))
                end
			},
			{
				text = 'Game Controls',
                onSelect = function()
                    gStateStack:push(HelpMenuState())
                end
			},
			{
				text = 'Exit Menu',
                onSelect = function()
                    gStateStack:pop()
                    gStateStack:pop()
                end
			}
		}
	}
end

function MenuState:update(dt)
	self.menu:update(dt)
	
	if love.keyboard.wasPressed('x') or love.keyboard.wasPressed('space') then
		gSounds['cancel']:play()
		
		gStateStack:pop()
		gStateStack:pop()
	end
end

function MenuState:render()
	self.menu:render()
end