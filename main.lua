--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)

    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/12/2019

    This game was inspired by my love of mythology (and RPGs!). Unfortunately, on such a tight deadline, I wasn't really
	able to do much world-building here. The boss character will poke fun at this when you fight her.
	While there's still a long way to go before this game will be ready for public consumption, I'm proud of what I've
	accomplished here so far. I was able to combine the logic from nearly half of our homework assignments (almost all
	the 2D ones!) to create a multi-genre game: a platformer with elements of adventure games and RPGs. My goal was to
	create a game with a retraux aesthetic and a nostalgic feel, hopefully evoking (perhaps quite crude versions of)
	such titles as "Hollow Knight" or "Freedom Planet."
	
	I hope you have as much fun playing it as I did programming it!
	And do look out for future versions -- my aspiration was always to keep working after the semester and eventually
	publish this game as an indie.

    Art Credits:
		Sprites:
			Aloria Dannon -- Yuki, Rose
			Ruri Mizuno -- Spells
			Bagzie -- Bat
				https://opengameart.org/node/26447
			RedShrike -- Skeleton
				https://opengameart.org/content/tower-defense-prototyping-assets-4-monsters-some-tiles-a-background-image
		
		Backgrounds & Tileset:
			Shackhal
				https://opengameart.org/content/multi-platformer-tileset-grassland-old-version

    Sound Credits:
		Music:
			Noirenex -- Intro Music
				https://freesound.org/people/noirenex/sounds/159398/
			FoolBoyMedia -- Main Theme
				https://freesound.org/people/FoolBoyMedia/sounds/320232/
			Sirkoto51 -- Boss Music
				https://freesound.org/people/Sirkoto51/sounds/443128/
			Mickleness -- Victory Fanfare
				https://freesound.org/people/mickleness/sounds/269198/
			LittleRobotSoundFactory -- Game Over Track
				https://freesound.org/people/LittleRobotSoundFactory/sounds/270329/
		
		Sound Effects:
			Ruri Mizuno -- most sound effects, I made myself using Bfxr
			JosePharaoh99 -- Death SFX
				https://freesound.org/people/josepharaoh99/sounds/364929/
	
	Code Credits:
		Many files have been copied from previous homework assignments as needed to save time
		instead of retyping them. Such files will state which assignment they were copied from
		in the opening comments of the file, as well as retaining the author signature. If the
		file has been significantly modified to accommodate new logic, it will be treated as a
		new file, with my name listed as the author. If the file has been modified, but only
		slightly (such as this one), my name will be listed as the author, but the assignment
		from which it originated will also be listed.
		This file was originally copied from assignment7, and modified for this game.
]]

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Kitsune Story Alpha')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    -- this time, we are using a stack for all of our states, where the field state is the
    -- foundational state; it will have its behavior preserved between state changes because
    -- it is essentially being placed "behind" other running states as needed (like the battle
    -- state)

    gStateStack = StateStack()
	
    gStateStack:push(StartState())

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateStack:render()
    push:finish()
end