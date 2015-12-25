## **Deprecated: Use [lua-loader](https://www.npmjs.com/package/lua-loader) instead.**

# commonjs.lua

implements the commonjs module [resolution pattern](https://nodejs.org/api/modules.html#modules_all_together) as defined by Node.

This allows you to install Lua packages from [npm](https://www.npmjs.com/) and require them like normal modules.

## Example

npm uses this pattern when it installs modules. So let's use npm! [installing npm](https://docs.npmjs.com/getting-started/installing-node)

In your project directory:

```sh
$ npm install luadash
```

```lua
require('./commonjs')
local __ = require('luadash')

function double (value)
  return value * 2
end

__.map(double, {1, 2, 3}) -- => {2, 4, 6}
```
