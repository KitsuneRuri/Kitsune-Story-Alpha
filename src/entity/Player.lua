--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019

    -- Player Class --
	
	
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
	
	self.swordsmanship = SKILL_DEFS['Swordsmanship'].baseValue
	self.riverMastery = SKILL_DEFS['River Mastery'].baseValue
	self.iceMastery = SKILL_DEFS['Ice Mastery'].baseValue
	self.windMastery = SKILL_DEFS['Wind Mastery'].baseValue
	self.healSkillLevel = 1
	self.aquaJetSkillLevel = 0
	self.iceShardSkillLevel = 1
	self.icicleSpearSkillLevel = 0
	self.icicleStormSkillLevel = 0
	self.protectiveWindsSkillLevel = 1
	self.windSliceSkillLevel = 0
	
	self.knownSpells = {'Heal', 'Ice Shard', 'Protective Winds'}
	
	self.selectedSpell = SKILL_DEFS['Ice Shard']
	
	self.skillPoints = 0
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
	
	-- debug for sword hitbox collision rect
	-- if self.swordHitbox ~= nil then
		-- love.graphics.setColor(0, 255, 64, 255)
		-- love.graphics.rectangle('line', self.swordHitbox.x, self.swordHitbox.y,
			-- self.swordHitbox.width, self.swordHitbox.height)
		-- love.graphics.setColor(255, 255, 255, 255)
	-- end
end

function Player:checkLeftCollisions(dt)
    -- check for left two tiles collision
    local tileTopLeft = self.map:pointToTile(self.x + 1, self.y + 1)
    local tileBottomLeft = self.map:pointToTile(self.x + 1, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if (tileTopLeft and tileBottomLeft) and (tileTopLeft:collidableLeft() or tileBottomLeft:collidableLeft()) then
        self.x = (tileTopLeft.x - 1) * TILE_SIZE + tileTopLeft.width - 1
    end
end

function Player:checkRightCollisions(dt)
    -- check for right two tiles collision
    local tileTopRight = self.map:pointToTile(self.x + self.width - 1, self.y + 1)
    local tileBottomRight = self.map:pointToTile(self.x + self.width - 1, self.y + self.height - 1)

    -- place player outside the X bounds on one of the tiles to reset any overlap
    if (tileTopRight and tileBottomRight) and (tileTopRight:collidableRight() or tileBottomRight:collidableRight()) then
        self.x = (tileTopRight.x - 1) * TILE_SIZE - self.width
    end
end

--[[
	A helper function to do everything that needs to be done when the player levels up,
	so that we can call this function repeatedly in a while loop until the player's level
	catches up with their exp.
]]
function Player:levelUp()
	gSounds['level-up']:play()
	
	self.expLevel = self.expLevel + 1
	self.skillPoints = self.skillPoints + 1
	
	self.maxHealth = self.maxHealth + self.healthGrowth
	self.maxMana = self.maxMana + self.manaGrowth
	self.attack = self.attack + self.attackGrowth
	self.magic = self.magic + self.magicGrowth
	
	self.currentHealth = self.maxHealth
	self.currentMana = self.maxMana
	
	self.expNext = (self.expLevel + 1) * (self.expLevel + 1) * (self.expLevel + 1)
	self.expToNext = self.expNext - self.expTotal
	if self.expToNext > 0 then
		self.expCurrent = self.expTotal - self.expLevel * self.expLevel * self.expLevel
	end
end

--[[
	A helper function to do everything that needs to be done when the player dies, so that
	we can unclog this code from the various Player States.
]]
function Player:die()
	gSounds['death']:play()
	
	gStateStack:push(FadeInState({
		r = 255, g = 255, b = 255
	}, 1,
	function()
		gStateStack:pop()
		
		gStateStack:push(GameOverState())
		gStateStack:push(FadeOutState({
			r = 255, g = 255, b = 255
		}, 1,
		function() end))
	end))
end