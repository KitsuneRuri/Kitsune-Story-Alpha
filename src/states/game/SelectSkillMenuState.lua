--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/10/2019
	
    -- SelectSkillMenuState Class --
]]

SelectSkillMenuState = Class{__includes = BaseState}

function SelectSkillMenuState:init(player)
	self.player = player
	
	self.selectSkillMenu = Menu {
        x = VIRTUAL_WIDTH / 2 + 32,
        y = 48,
        width = VIRTUAL_WIDTH / 2 - 64,
        height = VIRTUAL_HEIGHT / 2 + 16,
		displayCursor = true,
        items = {
			{
				text = 'Heal',
                onSelect = function()
					for k, spell in pairs(self.player.knownSpells) do
						if spell == SKILL_DEFS['Heal'].name then
							self.player.selectedSpell = SKILL_DEFS['Heal']
							
							-- reload the menus to display the correct currently selected spell
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillMenuState(self.player))
							gStateStack:push(SelectSkillMenuState(self.player))
						end
					end
                end
			},
			{
				text = 'Aqua Jet',
                onSelect = function()
                    for k, spell in pairs(self.player.knownSpells) do
						if spell == SKILL_DEFS['Aqua Jet'].name then
							self.player.selectedSpell = SKILL_DEFS['Aqua Jet']
							
							-- reload the menus to display the correct currently selected spell
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillMenuState(self.player))
							gStateStack:push(SelectSkillMenuState(self.player))
						end
					end
                end
			},
			{
				text = 'Ice Shard',
                onSelect = function()
					for k, spell in pairs(self.player.knownSpells) do
						if spell == SKILL_DEFS['Ice Shard'].name then
							self.player.selectedSpell = SKILL_DEFS['Ice Shard']
							
							-- reload the menus to display the correct currently selected spell
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillMenuState(self.player))
							gStateStack:push(SelectSkillMenuState(self.player))
						end
					end
                end
			},
			{
				text = 'Icicle Spear',
                onSelect = function()
					for k, spell in pairs(self.player.knownSpells) do
						if spell == SKILL_DEFS['Icicle Spear'].name then
							self.player.selectedSpell = SKILL_DEFS['Icicle Spear']
							
							-- reload the menus to display the correct currently selected spell
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillMenuState(self.player))
							gStateStack:push(SelectSkillMenuState(self.player))
						end
					end
                end
			},
			{
				text = 'Icicle Storm',
                onSelect = function()
                    for k, spell in pairs(self.player.knownSpells) do
						if spell == SKILL_DEFS['Icicle Storm'].name then
							self.player.selectedSpell = SKILL_DEFS['Icicle Storm']
							
							-- reload the menus to display the correct currently selected spell
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillMenuState(self.player))
							gStateStack:push(SelectSkillMenuState(self.player))
						end
					end
                end
			},
			{
				text = 'Protective Winds',
                onSelect = function()
                    for k, spell in pairs(self.player.knownSpells) do
						if spell == SKILL_DEFS['Protective Winds'].name then
							self.player.selectedSpell = SKILL_DEFS['Protective Winds']
							
							-- reload the menus to display the correct currently selected spell
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillMenuState(self.player))
							gStateStack:push(SelectSkillMenuState(self.player))
						end
					end
                end
			},
			{
				text = 'Wind Slice',
                onSelect = function()
                    for k, spell in pairs(self.player.knownSpells) do
						if spell == SKILL_DEFS['Wind Slice'].name then
							self.player.selectedSpell = SKILL_DEFS['Wind Slice']
							
							-- reload the menus to display the correct currently selected spell
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillMenuState(self.player))
							gStateStack:push(SelectSkillMenuState(self.player))
						end
					end
                end
			}
		}
	}
end

function SelectSkillMenuState:update(dt)
	self.selectSkillMenu:update(dt)
	
	if love.keyboard.wasPressed('x') then
		gSounds['cancel']:play()
		
		gStateStack:pop()
		gStateStack:pop()
	end
	
	if love.keyboard.wasPressed('space') then
		gStateStack:pop()
		gStateStack:pop()
		gStateStack:pop()
		gStateStack:pop()
	end
end

function SelectSkillMenuState:render()
	self.selectSkillMenu:render()
end