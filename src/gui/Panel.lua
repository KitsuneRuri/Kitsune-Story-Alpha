--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/02/2019
	
	-- Panel Class --
	
    Class for instantiating Panel objects for menu-based GUI.
	
	**Copied from assignment7**
	-- Changed the color of the panel to emulate Final Fantasy windows.
]]

Panel = Class{}

function Panel:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.visible = true
end

function Panel:update(dt)

end

function Panel:render()
    if self.visible then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, 3)
        love.graphics.setColor(64, 64, 192, 255)
        love.graphics.rectangle('fill', self.x + 2, self.y + 2, self.width - 4, self.height - 4, 3)
        love.graphics.setColor(255, 255, 255, 255)
    end
end

function Panel:toggle()
    self.visible = not self.visible
end