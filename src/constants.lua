--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)

    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- constants --

    Some global constants for our application.
]]

-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- global standard tile size
TILE_SIZE = 16

-- width and height of screen in tiles
SCREEN_TILE_WIDTH = VIRTUAL_WIDTH / TILE_SIZE
SCREEN_TILE_HEIGHT = VIRTUAL_HEIGHT / TILE_SIZE

-- camera scrolling speed
CAMERA_SPEED = 100

-- speed of scrolling background
-- BACKGROUND_SCROLL_SPEED = 10

-- player walking speed
PLAYER_WALK_SPEED = 150

-- player jumping velocity
PLAYER_JUMP_VELOCITY = -150

-- entity movement speed
BAT_MOVE_SPEED = 60
SKELETON_MOVE_SPEED = 40

-- boss movement speed
ROSE_MOVE_SPEED = 100

--
-- tile IDs
--
TILE_ID_EMPTY = 88
TILE_ID_FLAT_LEFT_EDGE = 1
TILE_ID_FLAT_GROUND = 2
TILE_ID_FLAT_RIGHT_EDGE = 3
TILE_ID_LEFT_CORNER = 5
TILE_ID_RIGHT_CORNER = 6
TILE_ID_DIRT_LEFT_EDGE = 12
TILE_ID_DIRT = 13
TILE_ID_DIRT_RIGHT_EDGE = 14

-- table of tiles that should trigger a collision
GROUND_TILES = {
    TILE_ID_FLAT_LEFT_EDGE, TILE_ID_FLAT_GROUND, TILE_ID_FLAT_RIGHT_EDGE, TILE_ID_LEFT_CORNER, TILE_ID_RIGHT_CORNER
}

BLOCK_RIGHT_MOVEMENT_TILES = {
	TILE_ID_LEFT_CORNER
}
BLOCK_LEFT_MOVEMENT_TILES = {
	TILE_ID_RIGHT_CORNER
}

--
-- game object IDs
--