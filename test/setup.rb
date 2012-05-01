require 'rubygems'
require 'bundler/setup'
require 'active_record'

Bundler.require

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'slim_scrooge'
