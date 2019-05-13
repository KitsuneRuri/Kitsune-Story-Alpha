--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    -- skill_defs --

    A file for storing the data associated with skills for the game.
	In this version, the only selectable skills are spells; however,
	I plan to add swordskills to the game at a later date, hence the
	abstraction to "skills" in many places in the code.
]]

SKILL_DEFS = {
	['Swordsmanship'] = {
		name = 'Swordsmanship',
		texture = '',
		icon = '',
		type = 'passive',
		element = 'None',
		description = 'Increases damage with slash attacks.',
		prerequisites = 'None',
		baseValue = 1
	},
	['River Mastery'] = {
		name = 'River Mastery',
		texture = '',
		icon = '',
		type = 'passive',
		element = 'Water',
		description = 'Increases damage and healing with water-element spells.',
		prerequisites = 'None',
		baseValue = 1
	},
	['Ice Mastery'] = {
		name = 'Ice Mastery',
		texture = '',
		icon = '',
		type = 'passive',
		element = 'Ice',
		description = 'Increases damage with ice-element spells.',
		prerequisites = 'None',
		baseValue = 1
	},
	['Wind Mastery'] = {
		name = 'Wind Mastery',
		texture = '',
		icon = '',
		type = 'passive',
		element = 'Wind',
		description = 'Increases damage with wind-element spells.',
		prerequisites = 'None',
		baseValue = 1
	},
	['Heal'] = {
		name = 'Heal',
		texture = '',
		icon = '',
		type = 'hold-to-cast',
		element = 'Water',
		description = 'Refills the health gauge while the button is held.',
		prerequisites = 'None',
		baseValue = 0.5,
		manaCost = 15
	},
	['Aqua Jet'] = {
		name = 'Aqua Jet',
		texture = '',
		icon = '',
		type = 'hold-to-cast',
		element = 'Water',
		description = 'While button is held, knocks back and damages enemies in front.',
		prerequisites = 'Water Mastery 3',
		baseValue = 1,
		manaCost = 30
	},
	['Ice Shard'] = {
		name = 'Ice Shard',
		texture = 'ice-shard',
		icon = '',
		type = 'press-to-cast',
		element = 'Ice',
		description = 'Creates a frozen projectile that deals damage to the first enemy it strikes.',
		prerequisites = 'None',
		baseValue = 1,
		manaCost = 30
	},
	['Icicle Spear'] = {
		name = 'Icicle Spear',
		texture = 'icicle-spear',
		icon = '',
		type = 'press-to-cast',
		element = 'Ice',
		description = 'Creates a large frozen spear that pierces through enemies, damaging several in a line.',
		prerequisites = 'Ice Mastery 3, Ice Shard 3',
		baseValue = 2,
		manaCost = 75
	},
	['Icicle Storm'] = {
		name = 'Icicle Storm',
		texture = 'icicle',
		icon = '',
		type = 'press-to-cast',
		element = 'Ice',
		description = 'Creates multiple projectiles, dealing damage in a wide area.',
		prerequisites = 'Ice Mastery 5, Icicle Spear 3',
		baseValue = 1,
		manaCost = 150
	},
	['Protective Winds'] = {
		name = 'Protective Winds',
		texture = '',
		icon = '',
		type = 'hold-to-cast',
		element = 'Wind',
		description = 'While button is held, knocks back and slightly damages nearby enemies.',
		prerequisites = 'None',
		baseValue = 0.5,
		manaCost = 15
	},
	['Wind Slice'] = {
		name = 'Wind Slice',
		texture = '',
		icon = '',
		type = 'press-to-cast',
		element = 'Wind',
		description = 'Creates a large blade of wind that damages the first enemy it contacts.',
		prerequisites = 'Wind Mastery 3',
		baseValue = 1,
		manaCost = 45
	}
}