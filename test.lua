--Make sure the commonjs loader pattern is in
require './commonjs'
--Make sure you `npm install luadash` first
local __ = require 'luadash'

local input = {1, 2, 3}
print("in: ", table.concat(input, ", "))
function double (value)
  return value * 2
end
print("out: ", table.concat(__.map(double, input), ", "))
