EnemyTurnState = Class{__includes = BaseState}

function EnemyTurnState:init(playstate)
    self.playstate = playstate
    self.playstate.enemy.isTurn = true

    --[[self.playstate.center = self.playstate.newcenter
    self.center = {x = self.playstate.enemy.x, y = self.playstate.enemy.y}
    self.playstate:changeCenter(
        self.playstate.center,
        self.center)
    self.playstate.newcenter = self.center]]

end

function EnemyTurnState:update(dt)
    if self.playstate.enemy.isTurn == false then
        self.playstate:changeState('transition',{
            next = 'playerturn'
    })
        self.playstate.turn = 'PLAYER'
    end
end