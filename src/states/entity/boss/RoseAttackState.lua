--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- RoseAttackState Class --
	
	
]]

RoseAttackState = Class{__includes = BaseState}

function RoseAttackState:init(entity, player)
	self.entity = entity
    self.player = player
    self.map = entity.map
	
    self.entity.texture = 'Rose-Attack'
	
	self.animation = Animation {
		frames = {1, 2, 3, 4, 5, 6},
		interval = 0.125
	}
	
    self.entity.currentAnimation = self.animation
	
	self.attackTimer = 0
end

function RoseAttackState:update(dt)
    self.entity.currentAnimation:update(dt)
	
	-- since this state is basically just a special attack, we can simply cancel it after a
	-- full animation has played
	self.attackTimer = self.attackTimer + dt
	if self.attackTimer >= 0.75 then
		self.entity:changeState('chasing')
	end
	
	-- boss heals by amount of damage dealt when connecting with this attack
	if self.entity:collides(self.player) and not self.player.flashing then
		self.entity:damage(-1 * self.entity.attack)
	end
end