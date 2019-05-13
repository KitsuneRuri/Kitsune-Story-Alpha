--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- Entity Class --

    
]]

Entity = Class{}

function Entity:init(def)
    self.name = def.name
	
    -- reference to level for tests against other entities & objects;
	-- also used to increase enemy stats at higher game levels
    self.gameLevel = def.gameLevel
	
	-- position
    self.x = def.x
    self.y = def.y

    -- velocity
    self.dx = 0
    self.dy = 0

    -- dimensions
    self.width = def.width
    self.height = def.height

    -- drawing offsets for padded sprites
    self.offsetX = def.offsetX or 0
	self.rightOffsetX = def.rightOffsetX or 0
    self.offsetY = def.offsetY or 0

    self.texture = def.stats.texture

    self.direction = def.direction or 'left'
	
	-- stats
    self.expLevel = def.stats.expLevel or 0
	
	self.expValue = def.stats.expValue or 0
	
	self.maxHealth = def.stats.baseHealth
	self.maxMana = def.stats.baseMana
	self.attack = def.stats.baseAttack
	self.magic = def.stats.baseMagic
	self.healthGrowth = def.stats.healthGrowth
	self.manaGrowth = def.stats.manaGrowth
	self.attackGrowth = def.stats.attackGrowth
	self.magicGrowth = def.stats.magicGrowth
	
	if self.gameLevel then
		self.maxHealth = self.maxHealth * self.gameLevel.level
		self.maxMana = self.maxMana * self.gameLevel.level
		self.attack = self.attack * self.gameLevel.level
		self.magic = self.magic * self.gameLevel.level
		
		self.expValue = self.expValue * self.gameLevel.level
	end
	
	self.currentHealth = self.maxHealth
	self.currentMana = self.maxMana
	
    self.expTotal = def.stats.expTotal or 0
	self.expCurrent = self.expTotal
	self.expNext = (self.expLevel + 1) * (self.expLevel + 1) * (self.expLevel + 1)
	self.expToNext = self.expNext
	
	self.knockbackImmune = def.stats.knockbackImmune or false
	
    -- flags for flashing the entity when hit
    self.flashing = false
    self.flashingDuration = 0
    self.flashingTimer = 0
    self.flashTimer = 0

    -- reference to tile map so we can check collisions
    self.map = def.map
end

function Entity:changeState(state, params)
    self.stateMachine:change(state, params)
end

function Entity:collides(entity)
    return not (self.x > entity.x + entity.width or entity.x > self.x + self.width or
                self.y > entity.y + entity.height or entity.y > self.y + self.height)
end

function Entity:damage(dmg)
    self.currentHealth = self.currentHealth - dmg
end

function Entity:knockback(dist, dir)
	if not self.knockbackImmune then   -- makes the boss immune to knockback
		if dir == 'right' then
			self.x = self.x + dist
		else
			self.x = self.x - dist
		end
	end
end

function Entity:flash(duration)
    self.flashing = true
    self.flashingDuration = duration
end

--[[
	A helper function to do everything that needs to be done when the player kills an enemy,
	so that we can unclog this code from the various Player States and the PlayState.
]]
function Entity:killedBy(player, ref)
	gSounds['kill']:play()
	
	player.expTotal = player.expTotal + self.expValue
	player.expCurrent = player.expCurrent + self.expValue
	player.expToNext = player.expToNext - self.expValue
	while player.expToNext <= 0 do
		player:levelUp()
	end
					
	table.remove(player.gameLevel.entities, ref)
end

function Entity:update(dt)
    if self.flashing then
        self.flashTimer = self.flashTimer + dt
        self.flashingTimer = self.flashingTimer + dt

        if self.flashingTimer > self.flashingDuration then
            self.flashing = false
            self.flashingTimer = 0
            self.flashingDuration = 0
            self.flashTimer = 0
        end
    end
	
    self.stateMachine:update(dt)
end

function Entity:render()
    -- draw sprite slightly transparent if flashing every 0.06 seconds
    if self.flashing and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setColor(255, 255, 255, 64)
    end
	
	if self.direction == 'right' then
		love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
			math.floor(self.x) + 16 - self.offsetX, math.floor(self.y) + 16 - self.offsetY, 0, 1, 1, 16, 16)
	else
		love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
			math.floor(self.x) + 16 - self.offsetX - self.rightOffsetX, math.floor(self.y) + 16 - self.offsetY, 0, -1, 1, 16, 16)
	end
	
    love.graphics.setColor(255, 255, 255, 255)
	
	-- debug for hurtbox collision rect
    -- love.graphics.setColor(255, 0, 64, 255)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end