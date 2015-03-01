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

class ProjectFile > ProjectEntity

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

class ProjectDirectory > ProjectEntity

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

   # The root directory of the project
   @rootDir
   
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
   
end

class ProjectBuilder

	@options=nil
	@rootDir
	
end