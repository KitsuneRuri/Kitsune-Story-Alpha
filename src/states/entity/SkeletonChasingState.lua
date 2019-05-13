--[[
    CSCI-E23a
	Final Project
	Kitsune Story Alpha (v0.1)
    
    Author: Ruri Mizuno
    ivoryespeon@aol.com
    Last modified: 05/11/2019
	
    -- SkeletonChasingState Class --
	
	
]]

SkeletonChasingState = Class{__includes = BaseState}

function SkeletonChasingState:init(entity, player)
	self.entity = entity
    self.player = player
    self.map = entity.map
	
    self.texture = entity.texture
	
	self.animation = Animation {
		frames = {1, 2, 3, 2},
		interval = 0.15
	}
	
    self.entity.currentAnimation = self.animation
end

function SkeletonChasingState:update(dt)
    self.entity.currentAnimation:update(dt)
	
    -- calculate difference between skeleton and player on both axes and only chase
	-- if horizontal distance <= 10 tiles and vertical distance <= 2 tiles
    local diffX = math.abs(self.player.x - self.entity.x)
	local diffY = math.abs(self.player.y - self.player.offsetY - self.entity.y)

    if diffX > 10 * TILE_SIZE or diffY > 2 * TILE_SIZE then
        self.entity:changeState('moving')
    elseif self.player.x < self.entity.x then
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - SKELETON_MOVE_SPEED * 1.5 * dt

        -- stop the skeleton if there's a missing tile on the floor to the left or a solid tile directly left
        local tileLeft = self.map:pointToTile(self.entity.x, self.entity.y)
        local tileBottomLeft = self.map:pointToTile(self.entity.x, self.entity.y + self.entity.height)

        if (tileLeft and tileBottomLeft) and (tileLeft:collidableLeft() or not tileBottomLeft:collidableGround()) then
            self.entity.x = self.entity.x + SKELETON_MOVE_SPEED * 1.5 * dt
        end
    else
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + SKELETON_MOVE_SPEED * 1.5 * dt

        -- stop the skeleton if there's a missing tile on the floor to the right or a solid tile directly right
        local tileRight = self.map:pointToTile(self.entity.x + self.entity.width, self.entity.y)
        local tileBottomRight = self.map:pointToTile(self.entity.x + self.entity.width, self.entity.y + self.entity.height)

        if (tileRight and tileBottomRight) and (tileRight:collidableRight() or not tileBottomRight:collidableGround()) then
            self.entity.x = self.entity.x - SKELETON_MOVE_SPEED * 1.5 * dt
        end
    end
end