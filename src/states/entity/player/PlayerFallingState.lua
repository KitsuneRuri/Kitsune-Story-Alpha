--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019

    -- PlayerFallingState Class --
	
	
]]

PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(player, gravity)
    self.player = player
    self.gravity = gravity
	self.player.texture = 'Yuki-Jump'
	
    self.animation = Animation {
		frames = {1, 2, 3, 4},
        interval = 0.1
    }
    self.player.currentAnimation = self.animation
end

function PlayerFallingState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy + self.gravity
    self.player.y = self.player.y + (self.player.dy * dt)

    -- look at two tiles below our feet and check for collisions
    local tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)
    local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

    -- if we get a collision beneath us, go into either walking or idle
    if (tileBottomLeft and tileBottomRight) and (tileBottomLeft:collidableGround() or tileBottomRight:collidableGround()) then
        self.player.dy = 0
        
        -- set the player to be walking or idle on landing depending on input
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('walking')
        else
            self.player:changeState('idle')
        end

        self.player.y = (tileBottomLeft.y - 1) * TILE_SIZE - self.player.height
    
    -- check side collisions and reset position
    elseif love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        self.player:checkLeftCollisions(dt)
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        self.player:checkRightCollisions(dt)
    end

    if love.keyboard.wasPressed('x') then
        self.player:changeState('jump-slash')
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