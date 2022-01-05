-- Copyright (c) 2022 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(fromX, fromY, toX, toY)
  local dx = math.abs(toX - fromX)
  local sx = fromX < toX and 1 or -1
  local dy = -math.abs(toY - fromY)
  local sy = fromY < toY and 1 or -1
  local err = dx + dy
  local x, y = fromX, fromY
  local nx, ny = x, y

  return function()
    if nx == toX and ny == toY then return nil end

    nx,ny = x, y
    local e2 = err + err
    if e2 >= dy then
      err = err + dy
      x = x + sx
    end
    if e2 <= dx then
      err = err + dx
      y = y + sy
    end
    return nx, ny
  end
end