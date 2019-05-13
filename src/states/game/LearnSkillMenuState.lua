--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
    -- LearnSkillMenuState Class --
]]

LearnSkillMenuState = Class{__includes = BaseState}

function LearnSkillMenuState:init(player)
	self.player = player
	
	self.learnSkillMenu = Menu {
        x = VIRTUAL_WIDTH / 2 + 32,
        y = 16,
        width = VIRTUAL_WIDTH / 2 - 64,
        height = VIRTUAL_HEIGHT - 32,
		displayCursor = true,
        items = {
			{
				text = 'Swordsmanship    ' .. tostring(self.player.swordsmanship),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.swordsmanship < 9 then
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.swordsmanship = self.player.swordsmanship + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'River Mastery     ' .. tostring(self.player.riverMastery),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.riverMastery < 9 then
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.riverMastery = self.player.riverMastery + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Ice Mastery       ' .. tostring(self.player.iceMastery),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.iceMastery < 9 then
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.iceMastery = self.player.iceMastery + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Wind Mastery      ' .. tostring(self.player.windMastery),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.windMastery < 9 then
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.windMastery = self.player.windMastery + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Heal                ' .. tostring(self.player.healSkillLevel),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.healSkillLevel < 9 then
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.healSkillLevel = self.player.healSkillLevel + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Aqua Jet           ' .. tostring(self.player.aquaJetSkillLevel),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.aquaJetSkillLevel < 9 and self.player.riverMastery >= 3 then
						-- add the spell to the list of known spells if this is the first skill point spent on it
						if self.player.aquaJetSkillLevel == 0 then
							table.insert(self.player.knownSpells, SKILL_DEFS['Aqua Jet'].name)
						end
						
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.aquaJetSkillLevel = self.player.aquaJetSkillLevel + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Ice Shard          ' .. tostring(self.player.iceShardSkillLevel),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.iceShardSkillLevel < 9 then
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.iceShardSkillLevel = self.player.iceShardSkillLevel + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Icicle Spear        ' .. tostring(self.player.icicleSpearSkillLevel),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.icicleSpearSkillLevel < 9 and
						self.player.iceMastery >= 3 and self.player.iceShardSkillLevel >= 3 then
							-- add the spell to the list of known spells if this is the first skill point spent on it
							if self.player.icicleStormSkillLevel == 0 then
								table.insert(self.player.knownSpells, SKILL_DEFS['Icicle Spear'].name)
							end
							
							self.player.skillPoints = self.player.skillPoints - 1
							self.player.icicleSpearSkillLevel = self.player.icicleSpearSkillLevel + 1
								
							-- reload the menus to display the correct skill levels and remaining skill points
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillPointsMenuState(self.player))
							gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Icicle Storm        ' .. tostring(self.player.icicleStormSkillLevel),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.icicleStormSkillLevel < 9 and
						self.player.iceMastery >= 5 and self.player.icicleSpearSkillLevel >= 3 then
							-- add the spell to the list of known spells if this is the first skill point spent on it
							if self.player.icicleStormSkillLevel == 0 then
								table.insert(self.player.knownSpells, SKILL_DEFS['Icicle Storm'].name)
							end
							
							self.player.skillPoints = self.player.skillPoints - 1
							self.player.icicleStormSkillLevel = self.player.icicleStormSkillLevel + 1
								
							-- reload the menus to display the correct skill levels and remaining skill points
							gStateStack:pop()
							gStateStack:pop()
							gStateStack:push(CurrentSkillPointsMenuState(self.player))
							gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Protective Winds   ' .. tostring(self.player.protectiveWindsSkillLevel),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.protectiveWindsSkillLevel < 9 then
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.protectiveWindsSkillLevel = self.player.protectiveWindsSkillLevel + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			},
			{
				text = 'Wind Slice          ' .. tostring(self.player.windSliceSkillLevel),
                onSelect = function()
					if self.player.skillPoints >= 1 and self.player.windSliceSkillLevel < 9 and self.player.windMastery >= 3 then
						-- add the spell to the list of known spells if this is the first skill point spent on it
						if self.player.windSliceSkillLevel == 0 then
							table.insert(self.player.knownSpells, SKILL_DEFS['Wind Slice'].name)
						end
						
						self.player.skillPoints = self.player.skillPoints - 1
						self.player.windSliceSkillLevel = self.player.windSliceSkillLevel + 1
							
						-- reload the menus to display the correct skill levels and remaining skill points
						gStateStack:pop()
						gStateStack:pop()
						gStateStack:push(CurrentSkillPointsMenuState(self.player))
						gStateStack:push(LearnSkillMenuState(self.player))
					end
                end
			}
		}
	}
end

function LearnSkillMenuState:update(dt)
	self.learnSkillMenu:update(dt)
	
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

function LearnSkillMenuState:render()
	self.learnSkillMenu:render()
end