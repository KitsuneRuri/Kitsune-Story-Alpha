--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
	-- Textbox Class --
	
    
	
	**Copied from assignment7**
	-- Changed the trigger key to Z.
]]

Textbox = Class{}

function Textbox:init(x, y, width, height, text, font)
    self.panel = Panel(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.text = text
    self.font = font or gFonts['small']
    _, self.textChunks = self.font:getWrap(self.text, self.width - 16)

    self.chunkCounter = 1
    self.endOfText = false
    self.closed = false

    self:next()
end

--[[
    Goes to the next page of text if there is any, otherwise toggles the textbox.
]]
function Textbox:nextChunks()
    local chunks = {}

    for i = self.chunkCounter, self.chunkCounter + 2 do
        table.insert(chunks, self.textChunks[i])

        -- if we've reached the number of total chunks, we can return
        if i == #self.textChunks then
            self.endOfText = true
            return chunks
        end
    end

    self.chunkCounter = self.chunkCounter + 3

    return chunks
end

function Textbox:next()
    if self.endOfText then
        self.displayingChunks = {}
        self.panel:toggle()
        self.closed = true
    else
        self.displayingChunks = self:nextChunks()
    end
end

function Textbox:update(dt)
    if love.keyboard.wasPressed('z') then
        self:next()
    end
end

function Textbox:isClosed()
    return self.closed
end

function Textbox:render()
    self.panel:render()
    
    love.graphics.setFont(self.font)
    for i = 1, #self.displayingChunks do
        love.graphics.print(self.displayingChunks[i], self.x + 3, self.y + 3 + (i - 1) * 16)
    end
end