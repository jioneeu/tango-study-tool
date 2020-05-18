class JapneseStudy
  def initialize
    @words_list = read_files
  end

  def read_files
    return IO.readlines("./lists.dat")
  end

  def begin
    puts "1. Add new words set"
    puts "2. Review"
    puts "0．Quit"
    print "> "
    choose = gets.to_i

    return if choose != 1 and choose != 2
    study_new if choose == 1
    review if choose == 2

  end

  def study_new
    today = Time.now
    today = "%02d%02d.dat" % [today.month, today.day]
    path = "review/all-words/#{today}"

    open('lists.dat', 'a') do |f|
      f.puts today
    end
    
    puts "======================================="
    puts "Enter the meaning of the word you're "
    puts "studying and press enter."
    puts "When you're done, type 'done' or 'exit'."
    puts "======================================="
    open(path, 'w') do |f|
      while true
        print "> "
        word = gets.chomp

        break if word == "done" or word == "exit"
        f.puts word
      end
    end
       
  end

  def review
    puts "Review from.."
    for i in 0...@words_list.size
      puts "#{i+1}. #{@words_list[i]}"
    end
    print "> "
    choose = gets.to_i
		return if @words_list[choose-1] == nil
    words_from = @words_list[choose-1].chomp
		path_to_all = "review/all-words/#{words_from}"
		path_to_missed = "review/missed-words/#{words_from}"

		puts "test: #{words_from}"

    puts "1. Review all words"
    puts "2. Review only words I missed" if File.exist? path_to_missed
    puts "0. quit"
    print "> "
    choose = gets.to_i
    return if choose != 1 and choose != 2

    words_set = nil
    if choose == 1
      words_set = IO.readlines(path_to_all)
    elsif choose == 2
			words_set = IO.readlines(path_to_missed)
    end

    words_set = words_set.shuffle

    puts "======================================="
    puts "Words from '#{words_from}' (#{words_set.size} words)."
    puts "Press enter to move on.."
    puts "======================================="
    words_set.each_with_index do |word, i|
      word = word.split('-')[0].strip
      print "#{i+1}: #{word.chomp}"
      gets
    end

    puts "======================================="
    puts "Answers"
    puts "======================================="
    words_set.each_with_index do |word, i|
			eng, ja = word.split('-').map(&:strip)
			printf "%02d: [%s] %s" % [i+1, ja, eng]
      gets
    end
  end
end

study = JapneseStudy.new
study.begin
