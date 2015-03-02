#!/usr/bin/ruby

# The base project listener is basically brain dead.
# It serves as a template for creating custom listeners.
# Not all listeners have to implement all of the following
# functions, and custom listeners can define other functions
# not in this list.
class ProjectListener

   def getName()
      unless @name
         @name = "noname"
      end
      @name
   end

   def setName(name)
      @name = name
   end

   def onCreate()
   end

   def onDelete()
   end

   def onInspect()
   end

   def onBuild()
   end

   def onClean()
   end
   
   def onUndo()
   end
   
end

# The MakeListener is a listener responsible 
# for managing project builds. It can do
# "make" and "make clean" commands and will
# generate generic Makefile for a given
# project.
class MakeListener < ProjectListener

   def initialize()
      @name = "make_listener"
   end
   
   def onCreate()
	   # need to create Makefile for this project
   end

   def onBuild()
      # OSUtils takes a list of commands, so we need to make a list around this command
      OSUtils.execute( ["make"] )
   end

   def onClean()
      # OSUtils takes a list of commands, so we need to make a list around this command
      OSUtils.execute( ["make clean"] )
   end
   
end

# Git project listener is responsible for 
# the version control of the project's source
# code. It will initialize repository on creation
# and will save the source code at each build cycle
class GitProjectListener < ProjectListener

   def onCreate()
      commands = []
      commands << "git init"
      commands << "git add -A"
      commands << "git commit -m 'project creation'"
      OSUtils.execute(commands)
      writeConfig()
   end

   def onDelete()
      # delete git data
      OSUtils.execute( ["rm -rf .git"] )
   end

   def onInspect()
      OSUtils.execute( ["git status"] )
   end
   
   def onUndo()
      OSUtils.execute( ["git reset --hard HEAD"] )
   end

   def onSave(message = "auto-save")
      OSUtils.execute( ["git add -A; git commit -m '#{message}' | head -n 1"] )
   end

   def writeConfig()
      File.open(".git/config", 'w') do |config|
         config.puts '[core]
         repositoryformatversion = 0
         filemode = false
         bare = false
         logallrefupdates = true
         symlinks = false
         ignorecase = true
         [color]
         status = auto

         [color "branch"]
         current = yellow black
         local = yellow
         remote = magenta

         [color "status"]
         added = green
         changed = cyan
         untracked = magenta
         deleted = red
         '
      end
   end

end
