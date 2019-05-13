--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- TileMap Class --
	
	**Copied from assignment4**
	**No changes made to code**
]]

Tile = Class{}

function Tile:init(x, y, id)
	self.x = x
	self.y = y

    self.width = TILE_SIZE
    self.height = TILE_SIZE

    self.id = id
end

--[[
    The following three functions check to see whether this ID is whitelisted as collidable
	in a global constants table, and which direction of movement it should block.
]]
function Tile:collidableGround(target)
    for k, v in pairs(GROUND_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:collidableRight(target)
    for k, v in pairs(BLOCK_RIGHT_MOVEMENT_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:collidableLeft(target)
    for k, v in pairs(BLOCK_LEFT_MOVEMENT_TILES) do
        if v == self.id then
            return true
        end
    end

    return false
end

function Tile:render()
    love.graphics.draw(gTextures['tileset'], gFrames['tiles'][self.id],
        (self.x - 1) * TILE_SIZE, (self.y - 1) * TILE_SIZE)
end