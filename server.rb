#!/usr/bin/env ruby

require 'webrick'

root = File.expand_path('.')
server = WEBrick::HTTPServer.new(:Port => 3017, :DocumentRoot => root)
trap 'INT' do server.shutdown end
server.start
