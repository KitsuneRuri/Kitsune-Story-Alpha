--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
	-- PlayState Class --
	
    The main state of the game.
	Here we render the background, set up the camera and the tileset for the level,
	and spawn the sprites. The MenuState can only be accessed from here, and will be
	pushed on top of this state, automatically pausing the game when accessed.
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camX = 0
    self.camY = 0
    self.farBackgroundX = 0
    self.nearBackgroundX = 0
	
    self.gameLevel = GameLevel(1)
	self.tileMap = self.gameLevel.tileMap
	
	-- variable to change the left map bound for the player and camera; used in boss encounter
	self.leftBound = 0
	
    self.gravityOn = true
	
	--[[
		Local gravity on my computer is much harsher than on most computers, due to my FPS of 500.
		I should set this value to 10 before releasing the game.
	]]
    self.gravityAmount = 1.2
	
	self:spawnPlayer()
	
	self.regenTimer = 0
	
	self.spawnTimer = 0
	
    self:spawnEnemies()
	
	-- flag for whether or not the boss encounter has begun.
	self.bossEventTriggered = false
	
    self.player:changeState('idle')
	
    gSounds['main-theme']:setLooping(true)
    gSounds['main-theme']:play()
end

function PlayState:update(dt)
    Timer.update(dt)
	
    -- remove any stray nils from game tables
    self.gameLevel:clear()
	
	-- slowly regenerate player mana (1% per second)
	self.regenTimer = self.regenTimer + dt
	if self.regenTimer >= 1 and self.player.currentMana < self.player.maxMana then
		self.player.currentMana = math.min(self.player.currentMana + math.floor(self.player.maxMana / 100), self.player.maxMana)
		self.regenTimer = self.regenTimer - 1
	end
	
    -- update game level, player, and player bars
    self.gameLevel:update(dt)
    self.player:update(dt)
	self.healthBar:setMax(self.player.maxHealth)
	self.healthBar:setValue(self.player.currentHealth)
	self.manaBar:setMax(self.player.maxMana)
	self.manaBar:setValue(self.player.currentMana)
	self.expBar:setMax(self.player.expNext - self.player.expLevel * self.player.expLevel * self.player.expLevel)
	self.expBar:setValue(self.player.expCurrent)
	
	-- check if spell projectiles have collided with enemies or traveled their maximum distance
	for k, object in pairs(self.gameLevel.objects) do
		for e, entity in pairs(self.gameLevel.entities) do
			if object.type == 'projectile' and entity:collides(object) then
				object.onCollide(entity)
				
				if not object.piercing then
					table.remove(self.player.gameLevel.objects, k)
				end
				
				if entity.currentHealth <= 0 then
					entity:killedBy(self.player, e)
				end
			end
		end
		
		if math.abs(object.distanceTraveled) > object.maxDistance then
			table.remove(self.gameLevel.objects, k)
		end
	end
	
	-- automatically begin the boss encounter when the player reaches the middle of the final
	-- screen width of the level
	if self.player.x >= TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH / 2 and not self.bossEventTriggered then
		self:bossEncounter()
	end
	
    -- constrain player x-coordinate no matter what
    if self.player.x <= self.leftBound then
        self.player.x = self.leftBound
    elseif self.player.x > TILE_SIZE * self.tileMap.width - self.player.width then
        self.player.x = TILE_SIZE * self.tileMap.width - self.player.width
    end
	
    self:updateCamera()
	
	-- call up the player menu if the player has pressed the spacebar
	if love.keyboard.wasPressed('space') then
		gStateStack:push(StatsMenuState(self.player))
		gStateStack:push(MenuState(self.player))
	end
	
	-- spawn new enemies occasionally (until the boss event is triggered)
	self.spawnTimer = self.spawnTimer + dt
	if self.spawnTimer >= 30 and not self.bossEventTriggered then
		self:spawnEnemies()
		self.spawnTimer = self.spawnTimer - 30
	end
	
	-- move on to the next level if the boss has been defeated
	if self.bossEventTriggered == true and not self.gameLevel.entities[1] then
		if self.gameLevel.level < 3 then
			gStateStack:push(FadeInState({
				r = 255, g = 255, b = 255
			}, 1,
			function()
				gSounds['boss-theme']:stop()
				gSounds['main-theme']:setLooping(true)
				gSounds['main-theme']:play()
				
				-- update the game level and its tileMap, as well as the player's references to the level and its tileMap
				self.gameLevel = GameLevel(self.gameLevel.level + 1)
				self.tileMap = self.gameLevel.tileMap
				self.player.gameLevel = self.gameLevel
				self.player.map = self.gameLevel.tileMap
				
				-- place the player back at the beginning of the level with a left bound of 0
				-- since the boss encounter is over (for now)
				self.leftBound = 0
				self.player.x = 0
				self.player.y = 10 * TILE_SIZE + 5
				self.player.direction = 'right'
				
				-- toggle the boss event flag so that we can trigger it again later in the level
				self.bossEventTriggered = false
				
				gStateStack:push(FadeOutState({
					r = 255, g = 255, b = 255
				}, 1,
				function() end))
			end))
		else
			gSounds['boss-theme']:stop()
			gSounds['victory']:play()
			
			gStateStack:push(FadeInState({
				r = 255, g = 255, b = 255
			}, 1,
			function()
				gStateStack:pop()
				
				gStateStack:push(VictoryState)
				gStateStack:push(FadeOutState({
					r = 255, g = 255, b = 255
				}, 1,
				function() end))
			end))
		end
	end
end

function PlayState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['sky'], 0, 0)
    love.graphics.draw(gTextures['far-trees'], math.floor(-self.farBackgroundX), 0)
    love.graphics.draw(gTextures['far-trees'], math.floor(-self.farBackgroundX + 240), 0)
    love.graphics.draw(gTextures['far-trees'], math.floor(-self.farBackgroundX + 480), 0)
    love.graphics.draw(gTextures['far-trees'], math.floor(-self.farBackgroundX + 720), 0)
    love.graphics.draw(gTextures['near-trees'], math.floor(-self.nearBackgroundX), 0)
    love.graphics.draw(gTextures['near-trees'], math.floor(-self.nearBackgroundX + 176), 0)
    love.graphics.draw(gTextures['near-trees'], math.floor(-self.nearBackgroundX + 352), 0)
    love.graphics.draw(gTextures['near-trees'], math.floor(-self.nearBackgroundX + 528), 0)
    
    -- translate the entire view of the scene to emulate a camera
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    
    self.gameLevel:render()

    self.player:render()
	self.healthBar:render()
	self.manaBar:render()
	self.expBar:render()
	
    love.graphics.pop()
end

function PlayState:updateCamera()
    -- clamp movement of the camera's X between the left map bound and the right map bound minus screen width,
    -- setting it half the screen to the left of the player so they are in the center
    self.camX = math.max(self.leftBound,
        math.min(TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH,
        self.player.x - ((VIRTUAL_WIDTH - TILE_SIZE) / 2)))

    -- adjust background X's to move more slowly than the rate of the camera for parallax
    self.farBackgroundX = (self.camX / 4) % 240
    self.nearBackgroundX = (self.camX / 2) % 176
	
	-- adjust health/mana/exp bar display to move along with the camera
	self.healthBar.x = self.camX + 8
	self.manaBar.x = self.camX + 8
	self.expBar.x = self.camX + 8
end

function PlayState:spawnPlayer()
	self.player = Player({
		x = 0,
		y = 10 * TILE_SIZE + 5,
		width = 22,
		height = 27,
		rightOffsetX = 10,
		offsetY = 5,
		direction = 'right',
		stats = ENTITY_DEFS['Yuki'],
		map = self.tileMap,
		gameLevel = self.gameLevel
	})
	
	self.player.stateMachine = StateMachine {
		['idle'] = function() return PlayerIdleState(self.player) end,
		['walking'] = function() return PlayerWalkingState(self.player) end,
		['ground-slash'] = function() return PlayerGroundSlashState(self.player) end,
		['cast-magic'] = function() return PlayerCastMagicState(self.player) end,
		['jump'] = function() return PlayerJumpState(self.player, self.gravityAmount) end,
		['jump-slash'] = function() return PlayerJumpSlashState(self.player) end,
		['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end
	}

    -- player health bar
    self.healthBar = ProgressBar {
        x = 8,
        y = 8,
        width = 128,
        height = 8,
        color = {r = 192, g = 64, b = 64},
        value = self.player.currentHealth,
        max = self.player.maxHealth
    }
	
	-- player mana bar
    self.manaBar = ProgressBar {
        x = 8,
        y = 16,
        width = 128,
        height = 8,
        color = {r = 64, g = 64, b = 192},
        value = self.player.currentMana,
        max = self.player.maxMana
    }

    -- player exp bar
    self.expBar = ProgressBar {
        x = 8,
        y = 24,
        width = 128,
        height = 8,
        color = {r = 192, g = 192, b = 64},
        value = self.player.expCurrent,
        max = self.player.expNext
    }
end

function PlayState:spawnEnemies()
	for k, data in pairs(LEVEL_EXTRAS[self.gameLevel.level]['Spawn_Points']) do
		local spawnPoint = SpawnPoint(data[1], data[2])
		
		if #self.gameLevel.entities < #LEVEL_EXTRAS[self.gameLevel.level]['Spawn_Points'] and
			math.abs(self.player.x - spawnPoint.x) > 5 then
				local enemy
				
				if math.random(2) == 1 then
					enemy = Entity {
						x = spawnPoint.x * TILE_SIZE,
						y = spawnPoint.y * TILE_SIZE,
						width = 20,
						height = 32,
						offsetX = 6,
						stats = ENTITY_DEFS['Bat'],
						map = self.tileMap,
						gameLevel = self.gameLevel
					}
					
					enemy.stateMachine = StateMachine {
						['idle'] = function() return BatIdleState(enemy, self.player) end,
						['moving'] = function() return BatMovingState(enemy, self.player) end,
						['chasing'] = function() return BatChasingState(enemy, self.player) end
					}
				else
					enemy = Entity {
						x = spawnPoint.x * TILE_SIZE,
						y = spawnPoint.y * TILE_SIZE,
						width = 32,
						height = 32,
						stats = ENTITY_DEFS['Skeleton'],
						map = self.tileMap,
						gameLevel = self.gameLevel
					}
					
					enemy.stateMachine = StateMachine {
						['idle'] = function() return SkeletonIdleState(enemy, self.player) end,
						['moving'] = function() return SkeletonMovingState(enemy, self.player) end,
						['chasing'] = function() return SkeletonChasingState(enemy, self.player) end
					}
				end
				
				enemy:changeState('moving')

				table.insert(self.gameLevel.entities, enemy)
		end
	end
end

function PlayState:bossEncounter()
	self.bossEventTriggered = true
	
	gSounds['main-theme']:stop()
	gSounds['boss-theme']:setVolume(0.6)
	gSounds['boss-theme']:setLooping(true)
	gSounds['boss-theme']:play()
	
	self.leftBound = TILE_SIZE * self.tileMap.width - VIRTUAL_WIDTH
	
	local boss = Entity({
		x = 350 * TILE_SIZE,
		y = 8 * TILE_SIZE + 17,
		width = 32,
		height = 47,
		stats = ENTITY_DEFS['Rose'],
		map = self.tileMap,
		gameLevel = self.gameLevel
	})
	
	boss.stateMachine = StateMachine {
		['idle'] = function() return RoseIdleState(boss, self.player) end,
		['chasing'] = function() return RoseChasingState(boss, self.player) end,
		['attack'] = function() return RoseAttackState(boss, self.player) end
	}
	
	boss:changeState('idle', {wait = 1.2})
	
	-- empties the table of entities so that the only one present (once added) is the boss
	for i = #self.gameLevel.entities, 1, -1 do
		table.remove(self.gameLevel.entities, #self.gameLevel.entities)
	end
	
	table.insert(self.gameLevel.entities, boss)
	
	if self.gameLevel.level == 1 then
		gStateStack:push(DialogueState("" ..
			"Well, well! If it isn't the Kitsune herself. Tell me, Yuki, why do you fight for them? " ..
			"...Who? The bunnies, of course! The ones I'm trying to rule? " ..
			"What...? That was never explained because this game is an early alpha version? Humph! " ..
			"Then an introduction is in order! I am the devious and powerful Succubun, Rose! " ..
			"And you'll never defeat me!"
		))
	elseif self.gameLevel.level == 2 then
		gStateStack:push(DialogueState("" ..
			"Back for more, are we, Yuki? " ..
			"*Growls* Unfortunately, since there wasn't time to get all the sprites made, and " ..
			"I'm no artist... Hey, why are you smirking? " ..
			"Never mind... The point is, I can't transform... " ..
			"But I'll still give you a run for your money!"
		))
	elseif self.gameLevel.level == 3 then
		gStateStack:push(DialogueState("" ..
			"Persistent little vixen, aren't you! " ..
			"But this isn't even my final form! I'll be back when the full game is released... " ..
			"Muhuhahaha...! "
		))
	end
end