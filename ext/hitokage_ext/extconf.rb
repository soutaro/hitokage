require "mkmf"

abort "should compile C++" unless have_library "stdc++"

$objs = ["hitokage_ext.o"]
Dir.glob(File.join(__dir__, "./double-conversion/*.cc")).each do |path|
  $objs << path.gsub(/\.cc$/, '.o')
end

create_makefile "hitokage/hitokage_ext"
