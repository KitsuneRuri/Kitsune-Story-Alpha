--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
    -- SkillInfoMenuState Class --
]]

SkillInfoMenuState = Class{__includes = BaseState}

function SkillInfoMenuState:init(player)
	self.player = player
	
	self.skillInfoMenu = Menu {
        x = VIRTUAL_WIDTH / 2 + 32,
        y = 16,
        width = VIRTUAL_WIDTH / 2 - 64,
        height = VIRTUAL_HEIGHT - 32,
		displayCursor = true,
        items = {
			{
				text = 'Swordsmanship    ' .. tostring(self.player.swordsmanship),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Swordsmanship']))
                end
			},
			{
				text = 'River Mastery     ' .. tostring(self.player.riverMastery),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['River Mastery']))
                end
			},
			{
				text = 'Ice Mastery       ' .. tostring(self.player.iceMastery),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Ice Mastery']))
                end
			},
			{
				text = 'Wind Mastery      ' .. tostring(self.player.windMastery),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Wind Mastery']))
                end
			},
			{
				text = 'Heal                ' .. tostring(self.player.healSkillLevel),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Heal']))
                end
			},
			{
				text = 'Aqua Jet           ' .. tostring(self.player.aquaJetSkillLevel),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Aqua Jet']))
                end
			},
			{
				text = 'Ice Shard          ' .. tostring(self.player.iceShardSkillLevel),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Ice Shard']))
                end
			},
			{
				text = 'Icicle Spear        ' .. tostring(self.player.icicleSpearSkillLevel),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Icicle Spear']))
                end
			},
			{
				text = 'Icicle Storm        ' .. tostring(self.player.icicleStormSkillLevel),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Icicle Storm']))
                end
			},
			{
				text = 'Protective Winds   ' .. tostring(self.player.protectiveWindsSkillLevel),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Protective Winds']))
                end
			},
			{
				text = 'Wind Slice          ' .. tostring(self.player.windSliceSkillLevel),
                onSelect = function()
					gStateStack:push(CurrentSkillInfoMenuState(SKILL_DEFS['Wind Slice']))
                end
			}
		}
	}
end

function SkillInfoMenuState:update(dt)
	self.skillInfoMenu:update(dt)
	
	if love.keyboard.wasPressed('x') then
		gSounds['cancel']:play()
		
		gStateStack:pop()
	end
	
	if love.keyboard.wasPressed('space') then
		gStateStack:pop()
		gStateStack:pop()
		gStateStack:pop()
	end
end

function SkillInfoMenuState:render()
	self.skillInfoMenu:render()
end