# -*- mode: ruby -*-

Dir.glob("#{Gem.default_dir}/gems/*/lib").each do |path|
  $LOAD_PATH << path
end

require 'pry-rails'
require 'pry-debugger'
require 'pry-coolline'
require 'pry-doc'
require 'hirb'
require 'awesome_print'

Hirb.enable
old_print = Pry.config.print
Pry.config.print = proc do |output, value|
  Hirb::View.view_or_page_output(value) || old_print.call(output, value)
end

