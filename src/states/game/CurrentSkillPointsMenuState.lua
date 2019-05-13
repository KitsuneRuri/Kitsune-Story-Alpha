--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/10/2019
	
    -- CurrentSkillPointsMenuState Class --
]]

CurrentSkillPointsMenuState = Class{__includes = BaseState}

function CurrentSkillPointsMenuState:init(player)
	self.player = player
	
	self.currentSkillPointsMenu = Menu {
        x = 32,
        y = 16,
        width = VIRTUAL_WIDTH / 2,
        height = 32,
		displayCursor = false,
        items = {
			{
				text = 'Current Skill Points: ' .. tostring(self.player.skillPoints),
                onSelect = function() end
			}
		}
	}
end

function CurrentSkillPointsMenuState:update(dt)
	self.currentSkillPointsMenu:update(dt)
end

function CurrentSkillPointsMenuState:render()
	self.currentSkillPointsMenu:render()
end