#!/usr/bin/ruby

# Set of utility classes for interfacing with the operating system

class OSUtils

   # Commands is an array/list of command strings
   def self.execute(commands)
      if commands
         commands.each do |command|
            system(command)
         end
      end
   end

end
