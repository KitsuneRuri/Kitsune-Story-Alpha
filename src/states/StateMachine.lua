--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 04/30/2019
	
	-- StateMachine Class --
	
    Class for initializing and utilizing the ubiquitous StateMachine.
	
	**Copied from assignment4**
	**No changes made to code**
]]

StateMachine = Class{}

function StateMachine:init(states)
	self.empty = {
		render = function() end,
		update = function() end,
		processAI = function() end,
		enter = function() end,
		exit = function() end
	}
	self.states = states or {} -- [name] -> [function that returns states]
	self.current = self.empty
end

function StateMachine:change(stateName, enterParams)
	assert(self.states[stateName]) -- state must exist!
	self.current:exit()
	self.current = self.states[stateName]()
	self.current:enter(enterParams)
end

function StateMachine:update(dt)
	self.current:update(dt)
end

function StateMachine:render()
	self.current:render()
end

--[[
	Used for states that can be controlled by the AI to influence update logic.
]]
function StateMachine:processAI(params, dt)
	self.current:processAI(params, dt)
end
