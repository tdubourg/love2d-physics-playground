--------------- License --------------- 
-- By tdubourg http://github.com/tdubourg
-- This work in under the CC-BY v3 license
-- The license can be found here http://creativecommons.org/licenses/by/3.0/legalcode
-- In short: as long as you do not remove this disclaimer, do what you want with this
---------------------------------------- 

require('debug')

DisplayComponent = {}
DisplayComponent.__index = DisplayComponent

function DisplayComponent.new(sprite_path, draw_centered, offset)
    local self = {}
    setmetatable(self, DisplayComponent)
    self.sprite = love.graphics.newImage(sprite_path)
    self.w = self.sprite:getWidth()
    self.h = self.sprite:getHeight()
    self.offset_x = 0
    self.offset_y = 0
    if draw_centered == nil then
        self.draw_centered = true
    else
        self.draw_centered = draw_centered
        if nil ~= offset then
            self.offset_x = offset.x
            self.offset_y = offset.y
        end
    end
    return self
end

function DisplayComponent:attach_to( game_object )
    self.go = game_object
end

function DisplayComponent:update( dt, game_object, args )
    -- @TODO : Store useful things
    self.last_dt = dt
end

function DisplayComponent:draw()
    if self.draw_centered then
        love.graphics.draw(self.sprite, self.go.centerx, self.go.centery, self.go.angle, 1.0, 1.0, self.w / 2.0, self.h / 2.0)
    else
        love.graphics.draw(self.sprite, self.go.posx + self.offset_x + self.w / 2.0, self.go.posy + self.offset_y + self.h / 2.0, self.go.angle, 1.0, 1.0, self.w / 2.0, self.h / 2.0)
    end
end