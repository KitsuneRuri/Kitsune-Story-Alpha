--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
    -- Dependencies --
	
    A file for organizing all of the project's global dependencies and assets.
]]

--
-- libraries
--

Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
Event = require 'lib/knife.event'

--
-- code files
--

-- utility
require 'src/constants'
require 'src/states/StateMachine'
require 'src/states/StateStack'
require 'src/Util'

-- entities
require 'src/entity/Entity'
require 'src/entity/entity_defs'
require 'src/entity/Player'

-- gui
require 'src/gui/Menu'
require 'src/gui/Panel'
require 'src/gui/ProgressBar'
require 'src/gui/Selection'
require 'src/gui/Textbox'

-- game states
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/FadeInState'
require 'src/states/game/FadeOutState'
require 'src/states/game/PlayState'
require 'src/states/game/MenuState'
require 'src/states/game/StatsMenuState'
require 'src/states/game/CurrentSkillMenuState'
require 'src/states/game/SelectSkillMenuState'
require 'src/states/game/CurrentSkillPointsMenuState'
require 'src/states/game/LearnSkillMenuState'
require 'src/states/game/SkillInfoMenuState'
require 'src/states/game/CurrentSkillInfoMenuState'
require 'src/states/game/HelpMenuState'
require 'src/states/game/GameOverState'
require 'src/states/game/DialogueState'
require 'src/states/game/VictoryState'

-- entity states
require 'src/states/entity/player/PlayerCastMagicState'
require 'src/states/entity/player/PlayerFallingState'
require 'src/states/entity/player/PlayerGroundSlashState'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerJumpSlashState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerWalkingState'

require 'src/states/entity/BatChasingState'
require 'src/states/entity/BatIdleState'
require 'src/states/entity/BatMovingState'
require 'src/states/entity/SkeletonChasingState'
require 'src/states/entity/SkeletonIdleState'
require 'src/states/entity/SkeletonMovingState'

require 'src/states/entity/boss/RoseAttackState'
require 'src/states/entity/boss/RoseIdleState'
require 'src/states/entity/boss/RoseChasingState'

-- general
require 'src/Animation'
require 'src/game_objects'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/Hitbox'
require 'src/level_extras'
require 'src/level_maps'
require 'src/skill_defs'
require 'src/SpawnPoint'
require 'src/Tile'
require 'src/TileMap'


gSounds = {
	-- music
	['intro-music'] = love.audio.newSource('sounds/intro_music.wav'),
	['main-theme'] = love.audio.newSource('sounds/main_theme_music.wav'),
	['boss-theme'] = love.audio.newSource('sounds/boss_music.wav'),
	
	-- fanfare
	['victory'] = love.audio.newSource('sounds/victory.mp3'),
	['game-over'] = love.audio.newSource('sounds/game_over.wav'),
	
	-- sfx
    ['jump'] = love.audio.newSource('sounds/jump.wav'),
	['katana'] = love.audio.newSource('sounds/katana.wav'),
	['healing'] = love.audio.newSource('sounds/heal.wav'),
	['aqua-jet'] = love.audio.newSource('sounds/aqua_jet.wav'),
	['ice-shard'] = love.audio.newSource('sounds/ice_shard.wav'),
	['icicle-spear'] = love.audio.newSource('sounds/icicle_spear.wav'),
	['icicle-storm'] = love.audio.newSource('sounds/icicle_storm.wav'),
	['protective-winds'] = love.audio.newSource('sounds/protective_winds.wav'),
	['wind-slice'] = love.audio.newSource('sounds/wind_slice.wav'),
    ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav'),
    ['kill'] = love.audio.newSource('sounds/kill.wav'),
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav'),
    ['death'] = love.audio.newSource('sounds/death.mp3'),
	['select'] = love.audio.newSource('sounds/select.wav'),
	['cancel'] = love.audio.newSource('sounds/cancel.wav'),
    ['level-up'] = love.audio.newSource('sounds/level_up.wav')
}

gTextures = {
	-- backgrounds
	['sky'] = love.graphics.newImage('graphics/Background_Sky.png'),
	['far-trees'] = love.graphics.newImage('graphics/Background_Far.png'),
	['near-trees'] = love.graphics.newImage('graphics/Background_Near.png'),
	
	-- tileset
    ['tileset'] = love.graphics.newImage('graphics/Grassland_Terrain_Tileset.png'),
	
    -- player
	['Yuki-Cast-Magic'] = love.graphics.newImage('graphics/Yuki_Cast_Magic.png'),
	['Yuki-Idle'] = love.graphics.newImage('graphics/Yuki_Idle.png'),
	['Yuki-Jump'] = love.graphics.newImage('graphics/Yuki_Jump.png'),
	['Yuki-Sword-Slash'] = love.graphics.newImage('graphics/Yuki_Sword_Slash.png'),
	['Yuki-Walk'] = love.graphics.newImage('graphics/Yuki_Walk.png'),
	
	-- enemies
	['bat'] = love.graphics.newImage('graphics/Bat.png'),
	['skeleton'] = love.graphics.newImage('graphics/Skeleton.png'),
	
	-- boss
	['Rose-Idle'] = love.graphics.newImage('graphics/Rose_Idle.png'),
	['Rose-Walk'] = love.graphics.newImage('graphics/Rose_Walk.png'),
	['Rose-Attack'] = love.graphics.newImage('graphics/Rose_Attack.png'),
	
	-- magic
	['aqua-jet'] = love.graphics.newImage('graphics/Aqua_Jet.png'),
	['ice-shard'] = love.graphics.newImage('graphics/Ice_Shard.png'),
	['icicle'] = love.graphics.newImage('graphics/Icicle.png'),
	['icicle-spear'] = love.graphics.newImage('graphics/Icicle_Spear.png'),
	['protective-winds'] = love.graphics.newImage('graphics/Protective_Winds.png'),
	['wind-slice'] = love.graphics.newImage('graphics/Wind_Slice.png'),
	
	-- cursor
	['cursor'] = love.graphics.newImage('graphics/cursor.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tileset'], TILE_SIZE, TILE_SIZE),
	['Yuki-Cast-Magic'] = GenerateQuads(gTextures['Yuki-Cast-Magic'], 32, 32),
	['Yuki-Idle'] = GenerateQuads(gTextures['Yuki-Idle'], 32, 32),
	['Yuki-Jump'] = GenerateQuads(gTextures['Yuki-Jump'], 32, 32),
	['Yuki-Sword-Slash'] = GenerateQuads(gTextures['Yuki-Sword-Slash'], 32, 32),
	['Yuki-Walk'] = GenerateQuads(gTextures['Yuki-Walk'], 32, 32),
    ['bat'] = GenerateQuads(gTextures['bat'], 32, 32),
    ['skeleton'] = GenerateQuads(gTextures['skeleton'], 32, 32),
    ['Rose-Idle'] = GenerateQuads(gTextures['Rose-Idle'], 32, 48),
    ['Rose-Walk'] = GenerateQuads(gTextures['Rose-Walk'], 32, 48),
    ['Rose-Attack'] = GenerateQuads(gTextures['Rose-Attack'], 32, 48),
	['aqua-jet'] = GenerateQuads(gTextures['aqua-jet'], 32, 64),
	['ice-shard'] = GenerateQuads(gTextures['ice-shard'], 32, 32),
	['icicle'] = GenerateQuads(gTextures['icicle'], 32, 32),
	['icicle-spear'] = GenerateQuads(gTextures['icicle-spear'], 64, 32),
	['protective-winds'] = GenerateQuads(gTextures['protective-winds'], 44, 54),
	['wind-slice'] = GenerateQuads(gTextures['wind-slice'], 32, 64),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 64),
    ['arcade-small'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 16),
    ['title'] = love.graphics.newFont('fonts/zelda.otf', 64)
}