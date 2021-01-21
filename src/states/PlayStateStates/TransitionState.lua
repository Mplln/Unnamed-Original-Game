TransitionState = Class{__includes = BaseState}

function TransitionState:init(playstate)
    self.playstate = playstate
    self.playstate.transitionAlpha = 255
    self.transitionAlpha = 255
    self.change = false

    Timer.tween(5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
        self.change = true
    end)

end

function TransitionState:update(dt)
    Timer.update(dt)
    self.playstate.transitionAlpha = self.transitionAlpha

    if self.change then 
        self.playstate:changeState('playerturn')
    end
end