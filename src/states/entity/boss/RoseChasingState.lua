--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- RoseChasingState Class --

    
]]

RoseChasingState = Class{__includes = BaseState}

function RoseChasingState:init(entity, player)
	self.entity = entity
    self.player = player
    self.map = entity.map
	
    self.entity.texture = 'Rose-Walk'
	
	self.animation = Animation {
		frames = {1, 2, 3, 4, 5, 6},
		interval = 0.1667
	}
	
    self.entity.currentAnimation = self.animation
	
	self.chaseTimer = 0
end

function RoseChasingState:update(dt)
    self.entity.currentAnimation:update(dt)

    -- after every second of chasing, small chance to go idle and merely laugh at the player
	self.chaseTimer = self.chaseTimer + dt
	if self.chaseTimer >= 1 then
        if math.random(8) == 1 then
            self.entity:changeState('idle', {
                wait = 1.2 * math.random(3)
            })
        end
		self.chaseTimer = self.chaseTimer - 1
	end
	
    if self.player.x < self.entity.x then
		self.entity.direction = 'left'
        self.entity.x = self.entity.x - ROSE_MOVE_SPEED * dt
    else
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + ROSE_MOVE_SPEED * dt
    end

    -- calculate difference between boss and player on X axis and only use special attack
	-- when within striking distance
    local diffX = math.abs(self.player.x - self.entity.x)

    if diffX <= self.player.width then
        self.entity:changeState('attack')
    end
end