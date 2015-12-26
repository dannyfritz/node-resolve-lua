local fs = require("fs")
local separator = package.config:match("^([^\n]*)")
local moduleDir = "node_modules"
local packageFile = "package.json"

local function getMain (modulePath)
  local packagePath = modulePath..separator..packageFile
  if not fs.isFile(packagePath) then
    return
  end
  local content = fs.read(packagePath)
  if content then
    local main = content:match("\"main\": \"([^\"]+)\"")
    return modulePath..separator..main
  end
end

local function splitPath (path)
  return path:gmatch("[^/\\]+")
end

local function joinPaths (dirs)
  return table.concat(dirs, separator)
end

local function checkModule (path, request)
  if fs.isDirectory(path..separator..moduleDir..separator..request) and
    fs.isFile(path..separator..moduleDir..separator..request..separator..packageFile)
  then
    return true
  else
    return false
  end
end

local function loadModule (path, request)
  local main = getMain(path..separator..moduleDir..separator..request)
  print(main)
  return fs.load(main)
end

local function nodeResolve (request)
  local cwd = fs.currentDir()
  local paths = {}
  for path in splitPath(cwd) do
    table.insert(paths, path)
  end
  if #paths == 0 then
    table.insert(paths, "")
  end
  while #paths > 0 do
    local path = joinPaths(paths)
    if checkModule(path, request) then
      return loadModule(path, request)
    end
    table.remove(paths, #paths)
  end
end

if package.loaders ~= nil then
  table.insert(package.loaders, 2, nodeResolve)
elseif package.searchers ~= nil then
  table.insert(package.searchers, 2, nodeResolve)
end
