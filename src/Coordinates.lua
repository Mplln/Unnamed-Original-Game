Coordinates = Class{}

function Coordinates:init()

end

function Coordinates:realToIso(x, y)
    local ix = x + y
    local iy = y - x

    return ix, iy
end

function Coordinates:isoToReal(x, y)
    local ry = (x + y)/2
    local rx = (x - y)/2

    return rx, ry
end

function Coordinates:realToPixel(x, y, width, height)
    local sx = x*width + OX
    local sy = y*height + OY

    return sx, sy
end