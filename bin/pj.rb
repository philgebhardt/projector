#!/usr/bin/ruby
#

load '../lib/prom.rb'
load '../lib/ioutils.rb'

if ARGV[0] == 'init'
   ProjectFactory.createProject()
end
