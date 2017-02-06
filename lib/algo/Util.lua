--- `algo.Util` class.
-- Some helper functions.
-- @classmod Util
local String = require "algo.String"
local lfs = require "lfs"

local Util = {}
package.loaded['Util'] = Util

Util.__index = Util

--- Get OS type and CPU architecture.
-- @return (os, arch) pair.
-- Ref: [os_name.lua](https://gist.github.com/soulik/82e9d02a818ce12498d1)
function Util:get_os()
	local raw_os_name, raw_arch_name = '', ''

	-- LuaJIT shortcut
	if jit and jit.os and jit.arch then
		raw_os_name = jit.os
		raw_arch_name = jit.arch
	else
		-- is popen supported?
		local popen_status, popen_result = pcall(io.popen, "")
		if popen_status then
			popen_result:close()
			-- Unix-based OS
			raw_os_name = io.popen('uname -s','r'):read('*l')
			raw_arch_name = io.popen('uname -m','r'):read('*l')
		else
			-- Windows
			local env_OS = os.getenv('OS')
			local env_ARCH = os.getenv('PROCESSOR_ARCHITECTURE')
			if env_OS and env_ARCH then
				raw_os_name, raw_arch_name = env_OS, env_ARCH
			end
		end
	end

	raw_os_name = (raw_os_name):lower()
	raw_arch_name = (raw_arch_name):lower()

	local os_patterns = {
		['windows'] = 'Windows',
		['linux'] = 'Linux',
		['mac'] = 'Mac',
		['darwin'] = 'Mac',
    ['osx'] = 'Mac',
		['^mingw'] = 'Windows',
		['^cygwin'] = 'Windows',
		['bsd$'] = 'BSD',
		['SunOS'] = 'Solaris',
	}

	local arch_patterns = {
		['^x86$'] = 'x86',
		['i[%d]86'] = 'x86',
		['amd64'] = 'x86_64',
    ['^x64$'] = 'x86_64',
		['x86_64'] = 'x86_64',
		['Power Macintosh'] = 'powerpc',
		['^arm'] = 'arm',
		['^mips'] = 'mips',
	}

	local os_name, arch_name = 'unknown', 'unknown'

	for pattern, name in pairs(os_patterns) do
		if raw_os_name:match(pattern) then
			os_name = name
			break
		end
	end
	for pattern, name in pairs(arch_patterns) do
		if raw_arch_name:match(pattern) then
			arch_name = name
			break
		end
	end

	return os_name, arch_name
end

--- Load C library by LuaJIT FFI.  We assume that our C libaray is in LUA_CPATH.
function Util:ffi_load(ffi, name)
	local cpath = String:new(package.cpath)
	cpath = cpath:gsub("?", name)

	for path in cpath:split(";") do
		if lfs.attributes(path:raw()) then
			local out = ffi.load(path:raw())
			if out then
				return out
			end
		end
	end

  -- If on Mac, check .dylib as well.
	local os_name, _ = self:get_os()
	if os_name == "Mac" then
		cpath = cpath:gsub(".so", ".dylib")

		for path in cpath:split(";") do
			if lfs.attributes(path:raw()) then
				local out = ffi.load(path:raw())
				if out then
					return out
				end
			end
		end
	end
end

return Util
