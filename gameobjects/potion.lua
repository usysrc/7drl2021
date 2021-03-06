local Timer = require "hump.timer"

local randomselect = require "lib.randomselect"
local Image = require "lib.image"
local Entity = require "gameobjects.entity"

local Potion = function(game, x,y)
    local tile = game.map.get(x,y)
    if tile and not tile.walkable then return end

    local potion = Entity()
    potion.img = Image.potion
    potion.name = "potion"
    potion.description = "20 hp"
    potion.use = function(self, entity)
        entity.hp = math.min(entity.maxhp, entity.hp + 20)
    end
    potion.type = "potion"
    potion.x = x or 40
    potion.y = y or 25
    potion.color = {1,1,1}


    potion.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.draw(self.img, self:getX(), self:getY())
        love.graphics.setColor(1,1,1)
    end

    potion.hit = function(self, other)
        self.hp = self.hp - other.attack
        if self.hp <= 0 then del(game.entities, self) end
        self.color = {0,0,0}
        Timer.after(0.25, function() self.color = {1,1,1} end)
    end

    potion.walkon = function(self, other)
        other:addItem(self)
        del(game.entities, self)
    end

    potion.walkinto = function(self, x,y,tx,ty)
    end



    return potion
end

return Potion