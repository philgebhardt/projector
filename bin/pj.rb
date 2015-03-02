#!/usr/bin/ruby
#

load '/vagrant/lib/prom.rb'

project = Project.new(Dir.pwd)

ARGV.each do |arg|
   case arg
   when 'init'
      ProjectFactory.createProject(project)
   when 'clean'
      ProjectBuilder.clean(project)
   when 'build'
      ProjectBuilder.build(project)
   when 'undo'
      ProjectVersioner.undo(project)
   when 'save'
      ProjectVersioner.save(project)
   else
      # do nothing
   end
end
