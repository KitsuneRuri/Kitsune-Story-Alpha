--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/02/2019
	
	-- FadeInState Class --
	
    
	
	**Copied from assignment7**
	**No changes made to code**
]]

FadeInState = Class{__includes = BaseState}

function FadeInState:init(color, time, onFadeComplete)
    self.r = color.r
    self.g = color.g
    self.b = color.b
    self.opacity = 0
    self.time = time

    Timer.tween(self.time, {
        [self] = {opacity = 255}
    })
    :finish(function()
        gStateStack:pop()
        onFadeComplete()
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.r, self.g, self.b, self.opacity)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(255, 255, 255, 255)
end