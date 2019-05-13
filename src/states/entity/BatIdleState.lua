--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/06/2019

    -- BatIdleState Class --

    
]]

BatIdleState = Class{__includes = BaseState}

function BatIdleState:init(entity, player)
	self.entity = entity
    self.player = player
    self.map = self.entity.map
	
    self.texture = entity.texture
	
	self.animation = Animation {
		frames = {6, 7, 8},
		interval = 0.3
	}
	
    self.entity.currentAnimation = self.animation
	
    self.waitTimer = 0
end

function BatIdleState:enter(params)
    self.waitPeriod = params.wait
end

function BatIdleState:update(dt)
    self.entity.currentAnimation:update(dt)
	
    if self.waitTimer < self.waitPeriod then
        self.waitTimer = self.waitTimer + dt
    else
        self.entity:changeState('moving')
    end
	
    local diffX = math.abs(self.player.x - self.entity.x)

    if diffX < 10 * TILE_SIZE then
        self.entity:changeState('chasing')
    end
end