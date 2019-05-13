--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
    -- HelpMenuState Class --
	
	A class to pop up a dialogue window.
	Used exclusively for boss encounter opening text in this game.
	
	**Copied from assignment7**
	-- Changed the window size to suit my game.
]]

DialogueState = Class{__includes = BaseState}

function DialogueState:init(text, callback)
    self.textbox = Textbox(16, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH - 32, 64, text, gFonts['small'])
    self.callback = callback or function() end
end

function DialogueState:update(dt)
    self.textbox:update(dt)

    if self.textbox:isClosed() then
        self.callback()
        gStateStack:pop()
    end
end

function DialogueState:render()
    self.textbox:render()
end