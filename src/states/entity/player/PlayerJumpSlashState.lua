--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019

    -- PlayerJumpSlashState Class --
	
	
]]

PlayerJumpSlashState = Class{__includes = BaseState}

function PlayerJumpSlashState:init(player)
    self.player = player
	self.player.texture = 'Yuki-Sword-Slash'

    self.animation = Animation {
        frames = {1, 2, 3, 4, 5},
        interval = 0.1
    }

    self.player.currentAnimation = self.animation
	
	-- create hitbox based on where the player is and facing
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight
	hitboxY = self.player.y
	hitboxWidth = 32 - self.player.width
	hitboxHeight = self.player.height - hitboxWidth

    if self.player.direction == 'left' then
        hitboxX = self.player.x - hitboxWidth
    else
        hitboxX = self.player.x + self.player.width
    end

    self.swordHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
	-- for debugging
    self.player.swordHitbox = self.swordHitbox
    
	gSounds['katana']:stop()
	gSounds['katana']:play()
end

function PlayerJumpSlashState:update(dt)
    self.player.currentAnimation:update(dt)

    -- check if our sword has collided with any entities and damage them if so
	if self.animation.currentFrame >= 3 then
		for k, entity in pairs(self.player.gameLevel.entities) do
			if entity:collides(self.swordHitbox) and not entity.flashing then
				gSounds['hit-enemy']:play()
				entity:damage(math.floor(self.player.attack * (0.9 + self.player.swordsmanship / 10)))
				entity:knockback(33, self.player.direction)
				entity:flash(0.5)
				if entity.currentHealth <= 0 then
					entity:killedBy(self.player, k)
				end
			end
		end
	end

    -- check if we've collided with any entities and take damage if so
    for k, entity in pairs(self.player.gameLevel.entities) do
        if entity:collides(self.player) and not self.player.flashing then
            gSounds['hit-player']:play()
			self.player:damage(entity.attack)
			self.player:knockback(16, entity.direction)
			self.player:flash(1)
			if self.player.currentHealth <= 0 then
				self.player:die()
			end
        end
    end

    if love.keyboard.wasPressed('x') then
        self.player:changeState('jump-slash')
    end
	
	if self.animation.currentFrame == 5 then
		self.player:changeState('falling')
	end
end