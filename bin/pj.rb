#!/usr/bin/ruby
#

load '../lib/prom.rb'
load '../lib/ioutils.rb'

project = Project.new(Dir.pwd)
project.setListeners( [
								MakeListener.new(),
								GitProjectListener.new()
							 ] )
							 
ARGV.each do |arg|
	case arg
	when 'init'
		ProjectFactory.createProject(project)
	when 'clean'
		ProjectBuilder.clean(project)
	when 'build'
		ProjectBuilder.build(project)
	else
	   # do nothing
	end
end