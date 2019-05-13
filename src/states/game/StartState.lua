--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019
	
    -- StartState Class --
	
	The title screen that displays at the beginning of a new game.
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    gSounds['intro-music']:setLooping(true)
    gSounds['intro-music']:play()
	
	-- utilizes a function very similar to GameLevel's extractTiles() to create a tile map
	-- for the title screen
	self.tiles = StartState:setupTiles()
    self.tileMap = TileMap(32, 18, self.tiles)
	
	-- utilizes a function very similar to PlayState's spawnPlayer() to spawn a player
	-- sprite that just idles
	self:spawnPlayer()
end

function StartState:update(dt)
    self.player:update(dt)
	
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateStack:push(FadeInState({
            r = 255, g = 255, b = 255
        }, 1,
        function()
            gSounds['intro-music']:stop()

            gStateStack:pop()
            
			gStateStack:push(PlayState())
			gStateStack:push(HelpMenuState())
            gStateStack:push(FadeOutState({
                r = 255, g = 255, b = 255
            }, 1,
            function() end))
        end))
	end
end

function StartState:render()
    love.graphics.draw(gTextures['sky'], 0, 0)
    love.graphics.draw(gTextures['far-trees'], 0, 0)
    love.graphics.draw(gTextures['far-trees'], 240, 0)
    love.graphics.draw(gTextures['far-trees'], 480, 0)
    love.graphics.draw(gTextures['near-trees'], 0, 0)
    love.graphics.draw(gTextures['near-trees'], 176, 0)
    love.graphics.draw(gTextures['near-trees'], 352, 0)
	
    self.tileMap:render()
	
    self.player:render()
	
	love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(128, 72, 32, 255)
    love.graphics.printf('Kitsune', 2, VIRTUAL_HEIGHT / 2 - 94, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Story', 22, VIRTUAL_HEIGHT / 2 - 62, VIRTUAL_WIDTH, 'center')
	
    love.graphics.setColor(255, 144, 64, 255)
    love.graphics.printf('Kitsune', 0, VIRTUAL_HEIGHT / 2 - 96, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Story', 20, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')
	
    love.graphics.setFont(gFonts['arcade-small'])
    love.graphics.setColor(128, 72, 32, 255)
    love.graphics.printf('Alpha v0.1', 22, VIRTUAL_HEIGHT / 2 - 14, VIRTUAL_WIDTH, 'center')
	
    love.graphics.setColor(255, 144, 64, 255)
    love.graphics.printf('Alpha v0.1', 20, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
	
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('PRESS ENTER', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end

--[[
	Creates a table of tiles unique to the StartState. The tiles here are always static.
]]
function StartState:setupTiles()
	local tiles = {}
	
	for y = 1, 12 do
		tiles[y] = {}
		
		for x = 1, 32 do
			tiles[y][x] = Tile(x, y, TILE_ID_EMPTY)
		end
	end
	
	tiles[13] = {}
		
	for x = 1, 32 do
		tiles[13][x] = Tile(x, 13, TILE_ID_FLAT_GROUND)
	end
	
	
	for y = 14, 18 do
		tiles[y] = {}
		
		for x = 1, 32 do
			tiles[y][x] = Tile(x, y, TILE_ID_DIRT)
		end
	end
	
	return tiles
end

--[[
	Spawns a 'mock' player sprite -- one that just stays in place and idles.
]]
function StartState:spawnPlayer()
	self.player = Player({
		x = 15 * TILE_SIZE + 10,
		y = 10 * TILE_SIZE + 5,
		width = 22,
		height = 27,
		rightOffsetX = 10,
		offsetY = 5,
		direction = 'right',
		stats = ENTITY_DEFS['Yuki'],
		map = self.tileMap
	})
	
	self.player.stateMachine = StateMachine {
		['idle'] = function() return PlayerIdleState(self.player) end
	}

    self.player:changeState('idle')
end