#!/usr/bin/env ruby

def match_school(input)
  regex = /School/

  if input =~ regex
    puts "The input '#{input}' matches the pattern 'School'."
  else
    puts "The input '#{input}' does not match the pattern 'School'."
  end
end

if ARGV.empty?
  puts "Please provide an argument."
else
  input_argument = ARGV[0]

  match_school(input_argument)
end

