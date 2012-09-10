require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# fix debugger problem in Ruby 1.9.3 & Ruby -> xml_printer.rb
# see http://stackoverflow.com/questions/8961367/aptana-3-ruby-debugger-exception-in-debugthread-loop-undefined-method-is-bin
class String
  def is_binary_data?
    ( self.count( "^ -~", "^\r\n" ).fdiv(self.size) > 0.3 || self.index( "\x00" ) ) unless empty?
  end
end
