#!/bin/ruby

load '/vagrant/lib/listener.rb'
load '/vagrant/lib/ioutils.rb'
load '/vagrant/lib/osutils.rb'

class ProjectEntity

   @name
   @location
   @parent

   def getName()
      @name
   end

   def setName(name)
      @name = name
   end

   def getLocation()
      @location
   end

   def setLocation(location)
      @location = location
   end

   def getParent()
      @parent
   end

   def setParent(projectDir)
      @parent = projectDir
   end

end

class ProjectFile <  ProjectEntity

   def getContent()
      content = nil
      File.open(@location, 'r') do |f|
         content = f.read
      end
      content
   end

   def setContent(content)
      File.open(@location, 'w') do |f|
         f.write content
      end
   end

   def isDirectory()
      false
   end

end

class ProjectDirectory < ProjectEntity

   @children

   def getChildren()
      unless @children
         @children = []
      end
      @children
   end

   def setChildren(children)
      @children = children
   end

   def getChildrenMap()
      map = {}
      dirs = []
      files = []
      @children.each do |child|
         if child.isDirectory()
            dirs << child
         else
            files << child
         end
      end
      map[:dirs] = dirs
      map[:files] = files
   end

   def isDirectory()
      true
   end

end

class Project

   # CONSTANTS
   DEFAULT_LISTENERS = [
   
         # TODO: Add make listener once it is ready
		 # MakeListener.new(),
		 
		 # Git listener should be last because
		 # we want to save only after all other listeners run
         GitProjectListener.new()
      ]
	  
   # The root directory of the project
   @rootDir

   # Listeners that will invoke stuff when you make a change
   # (no going to implement for a while)
   @listeners

   # Project name
   @name


   # Creates a Project object with 'dir' as
   # its root. If the parameter 'dir' is not
   # passed to the function, the default is
   # Dir.pwd (the present working directory)
   def initialize( dir )
      @rootDir = dir
   end

   def getRootDir()
      @rootDir
   end

   def setRootDir(dir)
      @rootDir = dir
   end

   def getListeners()
      unless @listeners # This means "unless listeners is set (not null)"
         @listeners = DEFAULT_LISTENERS
      end
      @listeners
   end

   def setListeners(listeners)
      @listeners = listeners
   end

end

class ProjectFactory

   def self.createProject(project = Project.new(Dir.pwd))
      
      project.getListeners().each do |listener|
         listener.onCreate()
      end
   end
   
end

class ProjectBuilder

   def self.build(project = Project.new(Dir.pwd))
      project.getListeners().each do |listener|
         listener.onBuild()
      end
   end

   def self.clean(project = Project.new(Dir.pwd))
      project.getListeners().each do |listener|
         listener.onClean()
      end
   end

end

class ProjectVersioner

   def self.undo(project = Project.new(Dir.pwd))
      project.getListeners().each do |listener|
         listener.onUndo()
      end
   end

   def self.save(project = Project.new(Dir.pwd))
      project.getListeners().each do |listener|
         listener.onSave()
      end
   end

end