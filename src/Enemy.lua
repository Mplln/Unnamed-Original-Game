Enemy = Class{__includes = Entity}

function Enemy:init(def)
    Entity.init(self, def)
    self.type = 'enemy'

    self.player = def.player

    self.vectors = {
        self.player.ix - self.ix,
        self.player.iy - self.iy
    }

    --self.animation = {{},{},{},{}}
    --self.animeTime = 1.5
    self.canMove = true

    --[[
    self.animation[1] = Animation {
        frames = {1, 3},
        interval = 0.25
    }
    self.animation[2] = Animation {
        frames = {4, 6},
        interval = 0.25
    }
    self.animation[3] = Animation {
        frames = {7, 9},
        interval = 0.25
    }
    self.animation[4] = Animation {
        frames = {10, 12},
        interval = 0.25
    }]]
end

local i = 1

local direction = 1
local function sign(n)
	return n < 0 and -1 or n > 0 and 1 or 0
end

function Enemy:update(dt)
    def = def or nil
    Entity.update(self, dt, def)

    self.vectors = {
        self.player.ix - self.ix,
        self.player.iy - self.iy
    } 

    Timer.update(dt)

    if self.canMove and (math.abs(self.vectors[1]) + math.abs(self.vectors[2]) > 1) and self.isTurn then
        self.canMove = false

        if (math.abs(self.vectors[1]) > 0 and direction == 1) or math.abs(self.vectors[2]) == 0 then
            self.directionX = sign(self.vectors[1])
            self.directionY = 0
        elseif (math.abs(self.vectors[2]) > 0 and direction == 2) or math.abs(self.vectors[1]) == 0 then
            self.directionX = 0
            self.directionY = sign(self.vectors[2])
        end

        if self.directionX == 0 then
            if self.directionY == 1 then -- this direction ⬃
                self.row = 1
                self.frameidle = 2
            else                         -- this direction ⬀ 
                self.row = 4
                self.frameidle = 11
            end
        elseif self.directionX == 1 then -- this direction ⬂
            self.row = 2
            self.frameidle = 5
        else                             -- this direction ⬁
            self.row = 3
            self.frameidle = 8
        end

        Timer.prior(self.animeTime,
        function(timer, dt)
            self.animation[self.row]:update(dt)
            self.frame = self.animation[self.row]:getCurrentFrame()
        end
        )
        :finish(function()
            self.canMove = true
            self.frame = self.frameidle
            self.isTurn = false
            if direction == 1 then
                direction = 2
            else
                direction = 1
            end
        end)
        
        Timer.tween(self.animeTime, {
            [self] = {ix = self.ix + self.directionX, iy = self.iy + self.directionY}
        })
    end
end

function Enemy:render()
    Entity.render(self)
end