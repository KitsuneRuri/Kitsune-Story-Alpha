--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019

    -- PlayerWalkingState Class --
	
	
]]

PlayerWalkingState = Class{__includes = BaseState}

function PlayerWalkingState:init(player)
    self.player = player
	self.player.texture = 'Yuki-Walk'
	
    self.animation = Animation {
        frames = {1, 2, 3, 4},
        interval = 0.2
    }
    self.player.currentAnimation = self.animation
end

function PlayerWalkingState:update(dt)
    self.player.currentAnimation:update(dt)

    -- idle if we're not pressing anything at all
    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
        self.player:changeState('idle')
    else
        local tileBottomLeft = self.player.map:pointToTile(self.player.x + 1,
								self.player.y + self.player.height)
        local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1,
								self.player.y + self.player.height)

        -- check to see whether there are any tiles beneath us
        if (tileBottomLeft and tileBottomRight) and
			(not tileBottomLeft:collidableGround() and not tileBottomRight:collidableGround()) then
				self.player.dy = 0
				self.player:changeState('falling')
        elseif love.keyboard.isDown('left') then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
            self.player.direction = 'left'
            self.player:checkLeftCollisions(dt)
        elseif love.keyboard.isDown('right') then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
            self.player.direction = 'right'
            self.player:checkRightCollisions(dt)
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

    if love.keyboard.wasPressed('c') and self.player.currentMana >= self.player.selectedSpell.manaCost then
        self.player:changeState('cast-magic')
    end

    if love.keyboard.wasPressed('x') then
        self.player:changeState('ground-slash')
    end

    if love.keyboard.wasPressed('z') then
        self.player:changeState('jump')
    end
end