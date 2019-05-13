--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019
	
	-- GameObject Class --
	
    Class for defining objects in the game world.
	
	**Copied from assignment5**
	-- Changes made to logic such that the main types of objects are projectiles.
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame

    -- whether it acts as an obstacle (to enemies) or not
    self.solid = def.solid or false
	
	-- whether this is a piercing projectile (which can hit multiple enemies) or not
	self.piercing = def.piercing or false

    -- self.defaultState = def.defaultState
    -- self.state = self.defaultState
    -- self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height
	
    -- drawing offsets for padded sprites
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0
	
	-- velocity variables for projectiles
	self.dx = def.dx or 0
	self.dy = def.dy or 0
	
	-- variables for storing distance traveled to delete projectiles
	self.distanceTraveled = 0
	self.maxDistance = def.maxDistance or 0

    -- default empty collision callback
    self.onCollide = function() end
end

function GameObject:update(dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
	self.distanceTraveled = self.distanceTraveled + math.abs(self.dx) * dt + math.abs(self.dy) * dt
end

function GameObject:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame], self.x - self.offsetX, self.y - self.offsetY)
	
	-- debug for projectile spell hitbox collision rect
    -- love.graphics.setColor(64, 64, 192, 255)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end