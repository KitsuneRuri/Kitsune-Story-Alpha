--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/10/2019
	
    -- CurrentSkillMenuState Class --
]]

CurrentSkillMenuState = Class{__includes = BaseState}

function CurrentSkillMenuState:init(player)
	self.player = player
	
	self.currentSkillMenu = Menu {
        x = 32,
        y = 16,
        width = VIRTUAL_WIDTH - 64,
        height = 32,
		displayCursor = false,
        items = {
			{
				text = 'Current Spell: ' .. (self.player.selectedSpell.name),
                onSelect = function() end
			}
		}
	}
end

function CurrentSkillMenuState:update(dt)
	self.currentSkillMenu:update(dt)
end

function CurrentSkillMenuState:render()
	self.currentSkillMenu:render()
end