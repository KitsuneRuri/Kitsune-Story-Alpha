--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- PlayerCastMagicState Class --
	
	Where all the magic happens...literally!
	But in actual point of fact, a lot of spell logic gets resolved via projectile GameObjects.
	A couple of spells currently have no animation (Aqua Jet and Protective Winds) because
	I was running out of time. Even the crude drawings I made (see the 'graphics' folder) had
	to be omitted because I was unable to make them properly disappear after the spell ended.
]]

PlayerCastMagicState = Class{__includes = BaseState}

function PlayerCastMagicState:init(player)
    self.player = player
	self.player.texture = 'Yuki-Cast-Magic'

    self.animation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8},
        interval = 0.1
    }
	
	self.alternateAnimation = Animation {
		frames = {4, 5, 6, 7, 8},
		interval = 0.1
	}

    self.player.currentAnimation = self.animation
	
	if self.player.selectedSpell.name == 'Aqua Jet' then
		if self.player.direction == 'right' then
			self.spellHitbox = Hitbox (self.player.x + self.player.width + 32,
										self.player.y - self.player.height - self.player.offsetY * 2,
										32, self.player.height * 2)
		else
			self.spellHitbox = Hitbox (self.player.x - 64, self.player.y - self.player.height - self.player.offsetY * 2,
										32, self.player.height * 2)
		end
	end
	
	if self.player.selectedSpell.name == 'Protective Winds' then
		self.spellHitbox = Hitbox (self.player.x - self.player.width / 2, self.player.y - self.player.height,
									self.player.width * 2, self.player.height * 2)
	end
	
	-- drain mana immediately on casting any spell
	self.player.currentMana = self.player.currentMana - self.player.selectedSpell.manaCost
	
	self.castTimer = 0
	self.finishedCasting = false
end

function PlayerCastMagicState:update(dt)
	self.castTimer = self.castTimer + dt
	
	if self.player.selectedSpell.type == 'hold-to-cast' and self.animation.currentFrame == 3 then
		self.player.currentAnimation = self.alternateAnimation 
	end
    self.player.currentAnimation:update(dt)

    -- check if we've collided with any entities and take damage if so
    for k, entity in pairs(self.player.gameLevel.entities) do
        if entity:collides(self.player) and not self.player.flashing then
			gSounds['healing']:stop()
            gSounds['hit-player']:play()
			self.player:damage(entity.attack)
			self.player:knockback(16, entity.direction)
			self.player:flash(1)
			self.player:changeState('idle')
			if self.player.currentHealth <= 0 then
				self.player:die()
			end
        end
    end
	
	if self.player.selectedSpell.type == 'hold-to-cast' then
		if self.castTimer >= 1 then
			self.player.currentMana = self.player.currentMana - self.player.selectedSpell.manaCost
			
			if self.player.selectedSpell.name == 'Heal' then
				gSounds['healing']:setVolume(0.5)
				gSounds['healing']:play()
				
				self.player:damage(-1 * math.floor(self.player.magic * self.player.selectedSpell.baseValue
																	* (0.9 + self.player.riverMastery / 10)
																	* (0.9 + self.player.healSkillLevel / 10)))
				if self.player.currentHealth >= self.player.maxHealth then
					self.player.currentHealth = self.player.maxHealth
					gSounds['healing']:stop()
					self.player:changeState('idle')
				end
			end
			
			self.castTimer = self.castTimer - 1
		end
	
		if self.player.selectedSpell.name == 'Aqua Jet' then
			gSounds['aqua-jet']:setLooping(true)
			gSounds['aqua-jet']:setVolume(0.5)
			gSounds['aqua-jet']:play()
			
			-- aquaJet = GameObject(GAME_OBJECT_DEFS['aqua-jet'], self.spellHitbox.x, self.spellHitbox.y)
			
			-- table.insert(self.player.gameLevel.objects, aquaJet)
			
			for k, entity in pairs(self.player.gameLevel.entities) do
				if entity:collides(self.spellHitbox) and not entity.flashing then
					gSounds['hit-enemy']:play()
					entity:damage(math.floor(self.player.magic * self.player.selectedSpell.baseValue
																* (0.9 + self.player.riverMastery / 10)
																* (0.9 + self.player.aquaJetSkillLevel / 10)))
					if entity.direction == 'left' then
						entity:knockback(66, 'right')
					else
						entity:knockback(66, 'left')
					end
					
					entity:flash(0.5)
					
					if entity.currentHealth <= 0 then
						entity:killedBy(self.player, k)
					end
				end
			end
		end
	
		if self.player.selectedSpell.name == 'Protective Winds' then
			gSounds['protective-winds']:setLooping(true)
			gSounds['protective-winds']:setVolume(0.5)
			gSounds['protective-winds']:play()
			
			-- protectiveWinds = GameObject(GAME_OBJECT_DEFS['protective-winds'], self.spellHitbox.x, self.spellHitbox.y)
			
			-- table.insert(self.player.gameLevel.objects, protectiveWinds)
			
			for k, entity in pairs(self.player.gameLevel.entities) do
				if entity:collides(self.spellHitbox) and not entity.flashing then
					gSounds['hit-enemy']:play()
					entity:damage(math.floor(self.player.magic * self.player.selectedSpell.baseValue
																* (0.9 + self.player.windMastery / 10)
																* (0.9 + self.player.protectiveWindsSkillLevel / 10)))
					if entity.direction == 'left' then
						entity:knockback(66, 'right')
					else
						entity:knockback(66, 'left')
					end
					
					entity:flash(0.5)
					
					if entity.currentHealth <= 0 then
						entity:killedBy(self.player, k)
					end
				end
			end
		end
		
		if not love.keyboard.isDown('c') or self.player.currentMana < self.player.selectedSpell.manaCost then
			gSounds['healing']:stop()
			gSounds['aqua-jet']:stop()
			gSounds['protective-winds']:stop()
			
			-- if self.player.selectedSpell.name == 'Aqua Jet' or self.player.selectedSpell.name == 'Protective Winds' then
				-- table.remove(self.player.gameLevel.objects, #self.player.gameLevel.objects)
			-- end
			
			self.player:changeState('idle')
		end
		
		-- debug for hold-to-cast spell hitbox collision rect -- doesn't work properly
		-- if self.spellHitbox ~= nil then
			-- love.graphics.setColor(64, 64, 192, 255)
			-- love.graphics.rectangle('line', self.spellHitbox.x, self.spellHitbox.y,
				-- self.spellHitbox.width, self.spellHitbox.height)
			-- love.graphics.setColor(255, 255, 255, 255)
		-- end
	end
	
	if self.player.selectedSpell.type == 'press-to-cast' then
		if self.player.selectedSpell.name == 'Ice Shard' and self.animation.currentFrame == 4 and not self.finishedCasting then
			gSounds['ice-shard']:stop()
			gSounds['ice-shard']:play()
				
			if self.player.direction == 'right' then
				iceShard = GameObject(GAME_OBJECT_DEFS['ice-shard-right'], self.player.x + self.player.width,
					self.player.y - self.player.offsetY + GAME_OBJECT_DEFS['ice-shard-right'].offsetY)
			else
				iceShard = GameObject(GAME_OBJECT_DEFS['ice-shard-left'], self.player.x - GAME_OBJECT_DEFS['ice-shard-left'].width,
					self.player.y - self.player.offsetY + GAME_OBJECT_DEFS['ice-shard-left'].offsetY)
			end
			
			iceShard.onCollide = function (entity)
				gSounds['hit-enemy']:play()
				entity:damage(math.floor(self.player.magic * SKILL_DEFS['Ice Shard'].baseValue
															* (0.9 + self.player.iceMastery / 10)
															* (0.9 + self.player.iceShardSkillLevel / 10)))
				if iceShard.dx > 0 then
					entity:knockback(33, 'right')
				else
					entity:knockback(33, 'left')
				end
				
				entity:flash(1)
			end
			
			table.insert(self.player.gameLevel.objects, iceShard)
			
			self.finishedCasting = true
		end
		
		if self.player.selectedSpell.name == 'Icicle Spear' and self.animation.currentFrame == 4 and not self.finishedCasting then
			gSounds['icicle-spear']:stop()
			gSounds['icicle-spear']:play()
			
			if self.player.direction == 'right' then
				icicleSpear = GameObject(GAME_OBJECT_DEFS['icicle-spear-right'], self.player.x + self.player.width,
					self.player.y - self.player.offsetY + GAME_OBJECT_DEFS['icicle-spear-right'].offsetY)
			else
				icicleSpear = GameObject(GAME_OBJECT_DEFS['icicle-spear-left'],
					self.player.x - GAME_OBJECT_DEFS['icicle-spear-left'].width,
					self.player.y - self.player.offsetY + GAME_OBJECT_DEFS['icicle-spear-left'].offsetY)
			end
			
			icicleSpear.onCollide = function (entity)
				if not entity.flashing then
					gSounds['hit-enemy']:play()
					entity:damage(math.floor(self.player.magic * SKILL_DEFS['Icicle Spear'].baseValue
																* (0.9 + self.player.iceMastery / 10)
																* (0.9 + self.player.icicleSpearSkillLevel / 10)))
					entity:flash(1)
				end
			end
			
			table.insert(self.player.gameLevel.objects, icicleSpear)
			
			self.finishedCasting = true
		end
		
		if self.player.selectedSpell.name == 'Icicle Storm' and self.animation.currentFrame == 4 and not self.finishedCasting then
			gSounds['icicle-storm']:stop()
			gSounds['icicle-storm']:play()
			
			for j = 1, 3 do
				for i = 1, 5 do
					if self.player.direction == 'right' then
						icicle = GameObject(GAME_OBJECT_DEFS['icicle-right'],
							self.player.x - GAME_OBJECT_DEFS['icicle-right'].width * (i - 2),
							self.player.y - self.player.offsetY - GAME_OBJECT_DEFS['icicle-right'].height * (j + 2))
					else
						icicle = GameObject(GAME_OBJECT_DEFS['icicle-left'],
							self.player.x - GAME_OBJECT_DEFS['icicle-left'].width * (i - 2),
							self.player.y - self.player.offsetY - GAME_OBJECT_DEFS['icicle-left'].height * (j + 2))
					end
					
					icicle.onCollide = function (entity)
						gSounds['hit-enemy']:play()
						entity:damage(math.floor(self.player.magic * SKILL_DEFS['Icicle Storm'].baseValue
																	* (0.9 + self.player.iceMastery / 10)
																	* (0.9 + self.player.icicleStormSkillLevel / 10)))
						if icicle.dx > 0 then
							entity:knockback(33, 'right')
						else
							entity:knockback(33, 'left')
						end
					end
			
					table.insert(self.player.gameLevel.objects, icicle)
				end
			end
			
			self.finishedCasting = true
		end
		
		if self.player.selectedSpell.name == 'Wind Slice' and self.animation.currentFrame == 4 and not self.finishedCasting then
			gSounds['wind-slice']:stop()
			gSounds['wind-slice']:play()
			
			if self.player.direction == 'right' then
				windSlice = GameObject(GAME_OBJECT_DEFS['wind-slice-right'], self.player.x + self.player.width,
					self.player.y - self.player.height - self.player.offsetY * 2 + GAME_OBJECT_DEFS['wind-slice-right'].offsetY)
			else
				windSlice = GameObject(GAME_OBJECT_DEFS['wind-slice-left'], self.player.x - GAME_OBJECT_DEFS['wind-slice-left'].width,
					self.player.y - self.player.height - self.player.offsetY * 2 + GAME_OBJECT_DEFS['wind-slice-left'].offsetY)
			end
			
			windSlice.onCollide = function (entity)
				gSounds['hit-enemy']:play()
				entity:damage(math.floor(self.player.magic * SKILL_DEFS['Wind Slice'].baseValue
															* (0.9 + self.player.windMastery / 10)
															* (0.9 + self.player.windSliceSkillLevel / 10)))
				if windSlice.dx > 0 then
					entity:knockback(33, 'right')
				else
					entity:knockback(33, 'left')
				end
				
				entity:flash(1)
			end
			
			table.insert(self.player.gameLevel.objects, windSlice)
			
			self.finishedCasting = true
		end
		
		if self.animation.currentFrame == 8 then
			self.player:changeState('idle')
		end
	end
end