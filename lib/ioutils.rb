#!/bin/ruby

# Utilities for I/O (like files)
class IOUtils
  def self.touch(file)
    if file
	  File.open(file, "w") {}
	end
  end
end
