--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
	-- SpawnPoint Class --
	
    Helper class for creating SpawnPoint objects.
]]

SpawnPoint = Class{}

function SpawnPoint:init(x, y)
    self.x = x
    self.y = y
end