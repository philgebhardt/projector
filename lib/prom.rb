#!/bin/ruby

class Project

   # The root directory of the project
   @root_dir
   # Project name
   @name
   
   
   # Creates a Project object with 'dir' as
   # its root. If the parameter 'dir' is not
   # passed to the function, the default is
   # Dir.pwd (the present working directory)
   def initialize( dir = Dir.pwd )
      @root_dir = dir
   end
   
   def map(from_dir = @root_dir)
      map = {}
	  Dir.entries(from_dir).each do |entry|
	    if File.directory?(entry)
			map[entry] = map(entry)
		else
		    map[entry] = File.extname(entry)
		end
	  end
   end
end