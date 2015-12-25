local fs = {}
local lfs = nil

if love ~= nil then
elseif pcall(function () lfs = require('lfs') end) then
else
  print("LFS or Love are required to access the filesystem.")
end

function fs.currentDir ()
  if love ~= nil then
    return love.filesystem.getWorkingDirectory()
  elseif lfs ~= nil then
    return lfs.currentdir()
  end
end

function fs.isDirectory (path)
  if love ~= nil then
    return love.filesystem.isDirectory(path)
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
    return love.filesystem.isFile(path)
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
    return love.filesystem.read(path)
  else
    local file = io.open(path, "rb")
    if file then
      return file:read("*a")
    end
  end
end

function fs.load (path)
  if love ~= nil then
    return love.filesystem.load(path)()
  else
    return assert(loadstring(assert(fs.read(path)), path))
  end
end

return fs
