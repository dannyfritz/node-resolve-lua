local fs = {}
local lfs = nil
local separator = package.config:match("^([^\n]*)")

if love ~= nil then
elseif pcall(function () lfs = require('lfs') end) then
else
  error("LFS or Love are required to access the filesystem.")
end

function fs.currentDir ()
  if love ~= nil then
    return "/"
  elseif lfs ~= nil then
    return lfs.currentdir()
  end
end

local function normalizePath (path)
  if love ~= nil then
    local normalizedPath = path:gsub("\\", "/")
    return normalizedPath
  end
  return path
end

function fs.isDirectory (path)
  if love ~= nil then
    return love.filesystem.isDirectory(normalizePath(path))
  elseif lfs ~= nil then
    local stat = lfs.attributes(path)
    if stat ~= nil then
      return stat.mode == "directory"
    end
    return false
  end
end

function fs.isFile (path)
  if love ~= nil then
    return love.filesystem.isFile(normalizePath(path))
  elseif lfs ~= nil then
    local stat = lfs.attributes(path)
    if stat ~= nil then
      return stat.mode == "file"
    end
    return false
  end
end

function fs.read (path)
  if love ~= nil then
    return love.filesystem.read(normalizePath(path))
  else
    local file = io.open(path, "rb")
    if file then
      return file:read("*a")
    end
  end
end

function fs.load (path)
  if love ~= nil then
    return love.filesystem.load(normalizePath(path))
  else
    return assert(loadstring(assert(fs.read(path)), path))
  end
end

return fs
