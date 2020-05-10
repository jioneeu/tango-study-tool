files = [
  "0510.dat"
]

files_wrongs = [
  "0510-wrongs.dat"
]

puts "Randomly pick a file and study ..."
puts " 1. every words I studied"
puts " 2. only words that I missed"
print " > "
choose = gets.to_i

study_from = choose==1 ? files.sample : files_wrongs.sample
words_list = IO.readlines(study_from)
words_list = words_list.shuffle

puts "======================================="
puts "Words from '#{study_from}' (#{words_list.size} words)."
puts "Press enter to move on.."
puts "======================================="
words_list.each_with_index do |word, i|
  print "#{i+1}: #{word.chomp}"
  gets
end
