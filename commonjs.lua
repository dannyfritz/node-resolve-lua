local lfs = require("lfs")

local function getMain (moduleDir)
  local package = io.open(moduleDir.."/package.json")
  if package then
    local content = package:read("*a")
    local main = content:match("\"main\": \"([^\"]+)\"")
    return moduleDir.."/"..main
  end
end

local function commonjs (targetModule)
  local path = lfs.currentdir()
  --TODO Go up a folder each time it isn't found
  local nodeModulesPath = path.."/node_modules"
  for module in lfs.dir(nodeModulesPath) do
    if module == targetModule then
      local moduleDir = nodeModulesPath.."/"..module
      local moduleMain = getMain(moduleDir)
      local file = io.open(moduleMain, "rb")
      if file then
        return assert(loadstring(assert(file:read("*a")), filename))
      end
    end
  end
end

table.insert(package.loaders, 2, commonjs)
