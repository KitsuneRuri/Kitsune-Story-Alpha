--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)

    Author: Colton Ogden
    cogden@cs50.harvard.edu
	
	Modified by: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/10/2019

    -- GameLevel Class --

    
	
	**Copied from assignment4**
	-- Changed the order of parameter entry and fixed a bug in the clear() function.
	-- Created a function to extract the tile data from a file of constants in order
		to make hard-coded levels.
]]

GameLevel = Class{}

function GameLevel:init(level)
	self.level = level
	self.tiles = GameLevel:extractTiles(level)
    self.tileMap = TileMap(352, 18, self.tiles)
    self.objects = {}
    self.entities = {}
end

--[[
    Remove all nil references from tables in case they've set themselves to nil.
]]
function GameLevel:clear()
    for i = #self.objects, 1, -1 do
        if not self.objects[i] then
            table.remove(self.objects, i)
        end
    end

    for i = #self.entities, 1, -1 do
        if not self.entities[i] then
            table.remove(self.entities, i)
        end
    end
end

function GameLevel:update(dt)
    self.tileMap:update(dt)

    for k, object in pairs(self.objects) do
        object:update(dt)
    end

    for k, entity in pairs(self.entities) do
        entity:update(dt)
    end
end

function GameLevel:render()
    self.tileMap:render()

    for k, object in pairs(self.objects) do
        object:render()
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end
end

--[[
	Creates a table of tiles. The top 5 tiles of each column are always empty,
	and the bottom 5 tiles are always dirt, so they're initialized accordingly.
	The rest of the tiles are initialized from IDs stored in level_defs.
]]
function GameLevel:extractTiles(levelRef)
	local tiles = {}
	
	for y = 1, 5 do
		tiles[y] = {}
		
		for x = 1, 352 do
			tiles[y][x] = Tile(x, y, TILE_ID_EMPTY)
		end
	end
	
	for y = 6, 13 do
		tiles[y] = {}
		
		for x = 1, 352 do
			tiles[y][x] = Tile(x, y, LEVEL_MAPS[levelRef][y - 5][x])
		end
	end
	
	
	for y = 14, 18 do
		tiles[y] = {}
		
		for x = 1, 352 do
			tiles[y][x] = Tile(x, y, TILE_ID_DIRT)
		end
	end
	
	return tiles
end