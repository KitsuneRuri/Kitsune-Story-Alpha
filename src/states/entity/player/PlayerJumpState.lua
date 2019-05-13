--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019

    -- PlayerJumpState Class --
	
	
]]

PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player, gravity)
    self.player = player
    self.gravity = gravity
	self.player.texture = 'Yuki-Jump'
	
    self.animation = Animation {
		frames = {1, 2, 3, 4},
        interval = 0.1
    }
    self.player.currentAnimation = self.animation
end

function PlayerJumpState:enter(params)
    gSounds['jump']:play()
    self.player.dy = PLAYER_JUMP_VELOCITY
end

function PlayerJumpState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy + self.gravity
    self.player.y = self.player.y + (self.player.dy * dt)

    if love.keyboard.wasPressed('x') then
        self.player:changeState('jump-slash')
    end

    -- go into the falling state when y velocity is positive
    if self.player.dy >= 0 then
        self.player:changeState('falling')
    end

    self.player.y = self.player.y + (self.player.dy * dt)

    -- test our sides for blocks
    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        self.player:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        self.player:checkRightCollisions(dt)
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