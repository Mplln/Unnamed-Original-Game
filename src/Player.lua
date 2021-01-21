Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.type = 'player'

    --self.animation = {{},{},{},{}}
    self.animeTime = 1.5
    self.canClick = true

    for k, animation in pairs(def.animations) do
        self.animation[k] = Animation {
            texture = animation.texture
            frames = animation.frames
            interval = animation.interval
        }
    end
    

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

function Player:update(dt, def)
    def = def or nil
    Entity.update(self, dt, def)

    Timer.update(dt)

    if love.mouse.isDown(1) and self.canClick and self.isTurn then
        if math.abs(self.ix - def.ix) + math.abs(self.iy - def.iy) == 1 then
            self.canClick = false

            self.directionX = def.ix - self.ix
            self.directionY = def.iy - self.iy

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
                self.canClick = true
                self.frame = self.frameidle
                self.isTurn = false
            end)
            
            Timer.tween(self.animeTime, {
                [self] = {ix = def.ix, iy = def.iy}
            })

        end
    end
    

end

function Player:render()
    Entity.render(self)
end