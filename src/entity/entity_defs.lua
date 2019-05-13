--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)

    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- entity_defs --

    A file for storing the data associated with game entities.
]]

ENTITY_DEFS = {
	['Yuki'] = {
		name = 'Yuki',
		texture = 'Yuki-Idle',
		expLevel = 1,
		expTotal = 0,
		baseHealth = 150,
		baseMana = 210,
		baseAttack = 20,
		baseMagic = 24,
		healthGrowth = 15,
		manaGrowth = 30,
		attackGrowth = 2,
		magicGrowth = 4
	},
	['Bat'] = {
		name = 'Bat',
		texture = 'bat',
		expValue = 4,
		baseHealth = 80,
		baseMana = 0,
		baseAttack = 15,
		baseMagic = 0,
		healthGrowth = 0,
		manaGrowth = 0,
		attackGrowth = 0,
		magicGrowth = 0
	},
	['Skeleton'] = {
		name = 'Skeleton',
		texture = 'skeleton',
		expValue = 10,
		baseHealth = 100,
		baseMana = 0,
		baseAttack = 25,
		baseMagic = 0,
		healthGrowth = 0,
		manaGrowth = 0,
		attackGrowth = 0,
		magicGrowth = 0
	},
	['Rose'] = {
		name = 'Rose',
		texture = 'Rose-Idle',
		expValue = 500,
		baseHealth = 1000,
		baseMana = 250,
		baseAttack = 100,
		baseMagic = 100,
		healthGrowth = 0,
		manaGrowth = 0,
		attackGrowth = 0,
		magicGrowth = 0,
		knockbackImmune = true
	}
}