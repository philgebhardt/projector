#!/bin/ruby

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

class ProjectListener

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
   
end

class MakeListener
   def onBuild()
      build()
   end

   def onClean()
      clean()
   end
   
   def build()
      system("make")
   end
   
   def clean()
      system("make clean")
   end
end

class GitProjectListener < ProjectListener

   def onCreate()
       system("git init")
	   system("git add -A")
	   system("git commit -m 'project creation'")
	   writeConfig()
   end
   
   def onDelete()
       system("rm -rf .git")
   end
   
   def onInspect()
       system("git status")
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

class Project

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
      unless @listeners
	     @listeners = []
	  end
	  @listeners
   end
   
   def setListeners(listeners)
      @listeners = listeners
   end
   
end

class ProjectFactory

	def self.createProject()
	   project = Project.new(Dir.pwd)
	   IOUtils.touch("main.cpp")
	   IOUtils.touch("functions.h")
	   IOUtils.touch("Makefile")
	   IOUtils.touch("README.txt")
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
