local fs = require("fs")
local separator = package.config:match("^([^\n]*)")
local moduleDir = "node_modules"
local packageFile = "package.json"

local function getMain (modulePath)
  local packagePath = modulePath..separator..packageFile
  local content = fs.read(packagePath)
  if content then
    local main = content:match("\"main\": \"([^\"]+)\"")
    return modulePath..separator..main
  end
end

local function splitPath (path)
  return path:gmatch("[^"..separator.."]+")
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
  return fs.load(main)
end

local function nodeResolve (request)
  local cwd = fs.currentDir()
  local paths = {}
  for path in splitPath(cwd) do
    table.insert(paths, path)
  end
  while #paths > 0 do
    local path = joinPaths(paths)
    if checkModule(path, request) then
      print(path..' is valid!')
      return loadModule(path, request)
    end
    print(path..' is invalid!')
    table.remove(paths)
    print(table.concat(paths, ", "))
  end
end

table.insert(package.loaders, 2, nodeResolve)
