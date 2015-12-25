# node-resolve-lua

implements node's require.resolve module [resolution pattern](https://nodejs.org/api/modules.html#modules_all_together) for Lua.

This allows you to install Lua packages from [npm](https://www.npmjs.com/) and require them like normal modules.

## Example

npm uses this pattern when it installs modules. So let's use npm! [installing npm](https://docs.npmjs.com/getting-started/installing-node)

In your project directory:

```sh
$ npm install luadash
```

Then to use the module in a Lua file do this:

```lua
require('./commonjs') --Only needs to be done once.
local __ = require('luadash')

function double (value)
  return value * 2
end

__.map(double, {1, 2, 3}) -- => {2, 4, 6}
```
