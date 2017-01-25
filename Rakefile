TARGET = "algo"
LUA = ENV['LUA'] || "luajit"
LUAFLAGS = "-lalgo"
LUAROCKS = ENV['LUAROCKS'] || "luarocks"
ROCKSPEC = "algo-0.1.0-1.rockspec"
LDOC = "ldoc"
DOC_DIR = "doc"
TEST_DIR = "test"
RM = "rm"
RMFLAGS = "-rf"

task 'test' => [:install] do
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/array_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/list_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/stack_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/queue_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/iterator_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/map_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/set_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/heap_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/vector_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/string_test.lua"
  sh "#{LUA} #{LUAFLAGS} #{TEST_DIR}/bigint_test.lua"
end

task 'install' => [:doc] do
  sh "#{LUAROCKS} make #{ROCKSPEC} --local"
end

task 'uninstall' do
  begin
    sh "#{LUAROCKS} remove #{TARGET} --local --force"
  rescue
    # Do nothing even the task failed
  end
end

task 'doc' do
  sh "#{LDOC}", "."
end

task 'clean' do
  sh "#{RM} #{RMFLAGS} #{DOC_DIR}"
end
