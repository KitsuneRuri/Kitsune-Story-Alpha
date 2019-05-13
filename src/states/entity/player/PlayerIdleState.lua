--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019

    -- PlayerIdleState Class --
	
	
]]

PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player
	self.player.texture = 'Yuki-Idle'

    self.animation = Animation {
        frames = {1, 2, 3, 4},
        interval = 0.2
    }

    self.player.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
    self.player.currentAnimation:update(dt)
	
	-- checks to see if we're on an actual level (gameLevel will be nil on the title screen)
	if self.player.gameLevel then
		if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
			self.player:changeState('walking')
		end

		if love.keyboard.wasPressed('c') and self.player.currentMana >= self.player.selectedSpell.manaCost then
			self.player:changeState('cast-magic')
		end

		if love.keyboard.wasPressed('x') then
			self.player:changeState('ground-slash')
		end

		if love.keyboard.wasPressed('z') then
			self.player:changeState('jump')
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
	end
end