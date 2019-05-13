--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019

    -- BatMovingState Class --

    
]]

BatMovingState = Class{__includes = BaseState}

function BatMovingState:init(entity, player)
	self.entity = entity
    self.player = player
    self.map = entity.map
	
    self.texture = entity.texture
	
	self.animation = Animation {
		frames = {6, 7, 8},
		interval = 0.3
	}
	
    self.entity.currentAnimation = self.animation

    self.movingDirection = math.random(2) == 1 and 'left' or 'right'
    self.entity.direction = self.movingDirection
    self.movingDuration = math.random(5)
    self.movingTimer = 0
end

function BatMovingState:update(dt)
    self.movingTimer = self.movingTimer + dt
    self.entity.currentAnimation:update(dt)

    -- reset movement direction and timer if timer is above duration
    if self.movingTimer > self.movingDuration then

        -- chance to go into idle state randomly
        if math.random(4) == 1 then
            self.entity:changeState('idle', {

                -- random amount of time for bat to be idle
                wait = math.random(5)
            })
        else
            self.movingDirection = math.random(2) == 1 and 'left' or 'right'
            self.entity.direction = self.movingDirection
            self.movingDuration = math.random(5)
            self.movingTimer = 0
        end
    elseif self.entity.direction == 'left' then
        self.entity.x = self.entity.x - BAT_MOVE_SPEED * dt

        -- stop the bat if there's a missing tile on the floor to the left or a solid tile directly left
        local tileLeft = self.map:pointToTile(self.entity.x, self.entity.y)
        local tileBottomLeft = self.map:pointToTile(self.entity.x, self.entity.y + self.entity.height)

        if (tileLeft and tileBottomLeft) and (tileLeft:collidableLeft() or not tileBottomLeft:collidableGround()) then
            self.entity.x = self.entity.x + BAT_MOVE_SPEED * dt

            -- reset direction if we hit a wall
            self.movingDirection = 'right'
            self.entity.direction = self.movingDirection
            self.movingDuration = math.random(5)
            self.movingTimer = 0
        end
    else
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + BAT_MOVE_SPEED * dt

        -- stop the bat if there's a missing tile on the floor to the right or a solid tile directly right
        local tileRight = self.map:pointToTile(self.entity.x + self.entity.width, self.entity.y)
        local tileBottomRight = self.map:pointToTile(self.entity.x + self.entity.width, self.entity.y + self.entity.height)

        if (tileRight and tileBottomRight) and (tileRight:collidableRight() or not tileBottomRight:collidableGround()) then
            self.entity.x = self.entity.x - BAT_MOVE_SPEED * dt

            -- reset direction if we hit a wall
            self.movingDirection = 'left'
            self.entity.direction = self.movingDirection
            self.movingDuration = math.random(5)
            self.movingTimer = 0
        end
    end
	
    -- calculate difference between bat and player on both axes and only chase
	-- if horizontal distance <= 10 tiles and vertical distance <= 2 tiles
    local diffX = math.abs(self.player.x - self.entity.x)
	local diffY = math.abs(self.player.y - self.player.offsetY - self.entity.y)

    if diffX <= 10 * TILE_SIZE and diffY <= 2 * TILE_SIZE then
        self.entity:changeState('chasing')
    end
end