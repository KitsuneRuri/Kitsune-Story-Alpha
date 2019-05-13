--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/06/2019
	
    -- StatsMenuState Class --
	
	
]]

StatsMenuState = Class{__includes = BaseState}

function StatsMenuState:init(player)
	self.statsMenu = Menu {
        x = 32,
        y = 16,
        width = VIRTUAL_WIDTH - 64,
        height = VIRTUAL_HEIGHT - 32,
		displayCursor = false,
        items = {
			{
				text = 'Level:   ' .. player.expLevel,
                onSelect = function() end
			},
			{
				text = 'Health:   ' .. player.currentHealth .. '/' .. player.maxHealth,
                onSelect = function() end
			},
			{
				text = 'Mana:     ' .. player.currentMana .. '/' .. player.maxMana,
                onSelect = function() end
			},
			{
				text = 'Attack:          ' .. player.attack,
                onSelect = function() end
			},
			{
				text = 'Magic:           ' .. player.magic,
                onSelect = function() end
			},
			{
				text = 'Experience:      ' .. player.expTotal,
                onSelect = function() end
			},
			{
				text = 'To Next Level:   ' .. player.expToNext,
                onSelect = function() end
			}
		}
	}
end

function StatsMenuState:update(dt)
	self.statsMenu:update(dt)
end

function StatsMenuState:render()
	self.statsMenu:render()
end