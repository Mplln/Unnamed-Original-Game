PlayerTurnState = Class{__includes = BaseState}

function PlayerTurnState:init(playstate)
    self.playstate = playstate

    self.x = self.playstate.lastCenter.x
    self.y = self.playstate.lastCenter.y
    self.start = false

    -- center camera
    Timer.tween(6, {
        [self] = {
            x = self.playstate.entities[self.playstate.playorder[self.playstate.turnCount]].x,
            y = self.playstate.entities[self.playstate.playorder[self.playstate.turnCount]].y
        }
    })
    :finish(function()
        self.playstate.entities[self.playstate.playorder[self.playstate.turnCount]].isTurn = true
        self.playstate.lastCenter.x = self.x 
        self.playstate.lastCenter.y = self.y
        self.start = true
    end)

end

function PlayerTurnState:update(dt)
    Timer.update(dt)
    self.playstate.translate.x = self.x - CENTERX
    self.playstate.translate.y = self.y - CENTERY

    if self.playstate.entities[self.playstate.playorder[self.playstate.turnCount]].isTurn == false and self.start then
        self.playstate:changeState('transition')
        if self.playstate.turnCount == #self.playstate.playorder then
            self.playstate.turnCount = 1
        else
            self.playstate.turnCount = self.playstate.turnCount + 1
        end
        self.playstate.turn = self.playstate.entities[self.playstate.playorder[self.playstate.turnCount]].name
    end
end

function PlayerTurnState:render()
    love.graphics.printf(CENTERX, 20, 500, 182, 'center')
    love.graphics.printf(CENTERY, 20, 520, 182, 'center')
end