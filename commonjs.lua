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
  print("looking for commonjs module: "..targetModule)
  local path = lfs.currentdir()
  for filename in lfs.dir(path) do
    if filename == "node_modules" then
      local nodeModulesPath = path.."/"..filename
      for module in lfs.dir(nodeModulesPath) do
        if module == targetModule then
          print("found "..targetModule.."!")
          local moduleDir = nodeModulesPath.."/"..module
          print(moduleDir)
          local moduleMain = getMain(moduleDir)
          print(moduleMain)
          local file = io.open(moduleMain, "rb")
          if file then
            return assert(loadstring(assert(file:read("*a")), filename))
          end
        end
      end
    end
  end
end

table.insert(package.loaders, 2, commonjs)
