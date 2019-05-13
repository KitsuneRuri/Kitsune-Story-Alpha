--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019
	
	-- game_objects --
]]

GAME_OBJECT_DEFS = {
    ['aqua-jet'] = {
        type = 'area-spell',
        texture = 'aqua-jet',
        frame = 1,
        solid = true,
        width = 32,
        height = 64
    },
    ['ice-shard-right'] = {
        type = 'projectile',
        texture = 'ice-shard',
        frame = 1,
        solid = true,
        width = 22,
        height = 5,
		offsetX = 4,
		offsetY = 12,
		dx = 256,
		dy = 0,
		maxDistance = VIRTUAL_WIDTH / 2 - 22
    },
    ['ice-shard-left'] = {
        type = 'projectile',
        texture = 'ice-shard',
        frame = 2,
        solid = true,
        width = 22,
        height = 5,
		offsetX = 4,
		offsetY = 12,
		dx = -256,
		dy = 0,
		maxDistance = VIRTUAL_WIDTH / 2 - 22
    },
    ['icicle-spear-right'] = {
        type = 'projectile',
        texture = 'icicle-spear',
        frame = 1,
        solid = true,
		piercing = true,
        width = 56,
        height = 13,
		offsetX = 4,
		offsetY = 8,
		dx = 256,
		dy = 0,
		maxDistance = VIRTUAL_WIDTH / 2
    },
    ['icicle-spear-left'] = {
        type = 'projectile',
        texture = 'icicle-spear',
        frame = 2,
        solid = true,
		piercing = true,
        width = 56,
        height = 13,
		offsetX = 4,
		offsetY = 8,
		dx = -256,
		dy = 0,
		maxDistance = VIRTUAL_WIDTH / 2
    },
    ['icicle-right'] = {
        type = 'projectile',
        texture = 'icicle',
        frame = 1,
        solid = true,
        width = 32,
        height = 32,
		dx = 256,
		dy = 144,
		maxDistance = VIRTUAL_WIDTH / 2 + VIRTUAL_HEIGHT / 2
    },
    ['icicle-left'] = {
        type = 'projectile',
        texture = 'icicle',
        frame = 2,
        solid = true,
        width = 32,
        height = 32,
		dx = -256,
		dy = 144,
		maxDistance = VIRTUAL_WIDTH / 2 + VIRTUAL_HEIGHT / 2
    },
    ['protective-winds'] = {
        type = 'area-spell',
        texture = 'protective-winds',
        frame = 1,
        solid = true,
        width = 44,
        height = 54
	},
    ['wind-slice-right'] = {
        type = 'projectile',
        texture = 'wind-slice',
        frame = 1,
        solid = true,
        width = 21,
        height = 56,
		offsetX = 7,
		offsetY = 8,
		dx = 256,
		dy = 0,
		maxDistance = VIRTUAL_WIDTH / 2
    },
    ['wind-slice-left'] = {
        type = 'projectile',
        texture = 'wind-slice',
        frame = 2,
        solid = true,
        width = 21,
        height = 56,
		offsetX = 4,
		offsetY = 8,
		dx = -256,
		dy = 0,
		maxDistance = VIRTUAL_WIDTH / 2
    }
}