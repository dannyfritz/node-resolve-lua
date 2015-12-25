# node-resolve-lua

[![npm](https://img.shields.io/npm/v/node-resolve-lua.svg?style=flat-square)](https://www.npmjs.com/package/node-resolve-lua)
[![npm](https://img.shields.io/npm/l/node-resolve-lua.svg?style=flat-square)](https://opensource.org/licenses/MIT)

Implements node's require.resolve module [resolution pattern](https://nodejs.org/api/modules.html#modules_all_together) for Lua.

This allows you to install Lua packages from [npm](https://www.npmjs.com/) and require them like normal modules.

All of the features of npm will come with using this pattern.

* Semantic Versioning of modules
* Modules installed locally, not globally
* Manage installed modules in a package.json file
* npm scripts
* [Tons more](https://docs.npmjs.com/)

## Usage

npm uses this pattern when it installs modules. So let's use npm! [installing npm](https://docs.npmjs.com/getting-started/installing-node)

In your project directory, we need to install node-resolve-lua:

```sh
$ npm install node-resolve-lua
```

```lua
--Only needs to be done once
require("./node_modules/node-resolve-lua/node-resolve")
```

And that's it! You're ready to include modules from npm now.

## Example Usage

If we wanted to use a module from npm such as [luadash](https://github.com/dannyfritz/luadash), we would do this:

```sh
$ npm install luadash
```

```lua
local __ = require("luadash")

function double (value)
  return value * 2
end

__.map(double, {1, 2, 3}) -- => {2, 4, 6}
```
