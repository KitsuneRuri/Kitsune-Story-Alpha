--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
	-- Selection Class --

    The Selection class gives us a list of textual items that link to callbacks;
    this particular implementation only has one dimension of items (vertically),
    but a more robust implementation might include columns as well for a more
    grid-like selection, as seen in many kinds of interfaces and games.
	
	**Copied from assignment7**
	-- Changed the trigger key to Z.
	-- Changed the sound played.
	-- Changed the render logic to left-justified text for all menus.
]]

Selection = Class{}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = def.font or gFonts['small']

    self.gapHeight = self.height / #self.items

    self.currentSelection = 1
	
	self.displayCursor = def.displayCursor
end

function Selection:update(dt)
    if love.keyboard.wasPressed('up') and self.displayCursor then
        if self.currentSelection == 1 then
            self.currentSelection = #self.items
        else
            self.currentSelection = self.currentSelection - 1
        end
        
        gSounds['select']:stop()
        gSounds['select']:play()
    elseif love.keyboard.wasPressed('down') and self.displayCursor then
        if self.currentSelection == #self.items then
            self.currentSelection = 1
        else
            self.currentSelection = self.currentSelection + 1
        end
        
        gSounds['select']:stop()
        gSounds['select']:play()
    elseif love.keyboard.wasPressed('z') then
			self.items[self.currentSelection].onSelect()
        
			gSounds['select']:stop()
			gSounds['select']:play()
    end
end

function Selection:render()
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- draw selection marker if we're at the right index
        if i == self.currentSelection and self.displayCursor then
            love.graphics.draw(gTextures['cursor'], self.x - 8, paddedY)
        end
		
		love.graphics.printf(self.items[i].text, self.x + 8, paddedY, self.width, 'left')
		
        currentY = currentY + self.gapHeight
    end
end