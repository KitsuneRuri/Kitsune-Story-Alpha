--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
    -- CurrentSkillInfoMenuState Class --
]]

CurrentSkillInfoMenuState = Class{__includes = BaseState}

function CurrentSkillInfoMenuState:init(skill)
	self.player = player
	
	self.currentSkillInfoMenu = Menu {
        x = 32,
        y = 16,
        width = VIRTUAL_WIDTH - 64,
        height = VIRTUAL_HEIGHT / 2,
		displayCursor = false,
        items = {
			{
				text = '' .. skill.name,
                onSelect = function()
					gStateStack:pop()
				end
			},
			{
				text = 'Element:  ' .. skill.element,
                onSelect = function()
					gStateStack:pop()
				end
			},
			{
				text = '' .. skill.description,
                onSelect = function()
					gStateStack:pop()
				end
			},
			{
				text = 'Prerequisites:  ' .. skill.prerequisites,
                onSelect = function()
					gStateStack:pop()
				end
			}
		}
	}
end

function CurrentSkillInfoMenuState:update(dt)
	self.currentSkillInfoMenu:update(dt)
	
	if love.keyboard.wasPressed('x') then
		gSounds['cancel']:play()
		
		gStateStack:pop()
	end
	
	if love.keyboard.wasPressed('space') then
		gStateStack:pop()
		gStateStack:pop()
		gStateStack:pop()
		gStateStack:pop()
	end
end

function CurrentSkillInfoMenuState:render()
	self.currentSkillInfoMenu:render()
end