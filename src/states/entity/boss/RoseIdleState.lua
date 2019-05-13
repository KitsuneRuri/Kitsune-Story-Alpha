--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- RoseIdleState Class --

    
]]

RoseIdleState = Class{__includes = BaseState}

function RoseIdleState:init(entity, player)
	self.entity = entity
    self.player = player
    self.map = self.entity.map
	
    self.entity.texture = 'Rose-Idle'
	
	self.animation = Animation {
		frames = {1, 2, 3, 4, 5, 6},
		interval = 0.2
	}
	
    self.entity.currentAnimation = self.animation
	
    self.waitTimer = 0
end

function RoseIdleState:enter(params)
    self.waitPeriod = params.wait
end

function RoseIdleState:update(dt)
    self.entity.currentAnimation:update(dt)
	
	if self.waitTimer < self.waitPeriod then
        self.waitTimer = self.waitTimer + dt
    else
        self.entity:changeState('chasing')
    end
	
    local diffX = math.abs(self.player.x - self.entity.x)

    if diffX <= self.player.width then
        self.entity:changeState('attack')
    end
end