# todo
# 1) непрацює порівняння з буквою "і", неправильний формат
# 2) невірно працює алгоритм жовтих букв: регілярний вираз вибирає з блоку одну з букв
# а потрібно щоб він вибирав тільки однубукву, і більше її не вибирав в інших блоках
# 3)

if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [$stdin, $stdout].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

puts 'Введіть кількість букв'
count_chars = $stdin.gets.chomp.to_i

if File.exist?('data/words.txt')
  f = File.new('data/words.txt', 'r:UTF-8')
  words = f.readlines
  f.close

  # Видалимо всі лишні слова, більше і менше 5 символів, та тіщо містять хочаб один символ [.,-]
  words.delete_if { |item| (item.length > count_chars + 1) || (item.length < count_chars + 1) || item =~ /[.,-]+/ }
else
  puts 'файл відсутній'
  exit
end

words.each { |item| item.chomp!.downcase! }

green_letters = //
yelow_letters = //
yellow_string = ''
bad_letters = //
bad_string = ''

choice = 0
puts words.to_s

# Замикааємо в цикл роботу з користувачем
until choice == 1
  puts 'Перелік слів'
  puts 'Доступні фільтри'

  puts "Зелені букви #{green_letters}"
  green_string = $stdin.gets.chomp
  green_string = '.' * count_chars if green_string.length.zero?
  green_letters = Regexp.new(green_string)
  puts "Зелені букви #{green_letters}"

  puts "Жовті букви #{yelow_letters}"
  user_chars = $stdin.gets.chomp.to_s
  yellow_string += user_chars
  yelow_letters = Regexp.new(".*[#{yellow_string}]+.*" * yellow_string.size)
  puts "Жовті букви #{yelow_letters}"

  puts "Чорні букви #{bad_letters}"
  user_chars = $stdin.gets.chomp.to_s
  bad_string += user_chars
  bad_letters = Regexp.new("[^#{bad_string}]{#{count_chars}}")
  puts "Чорні букви #{bad_letters}"

  words.select! do |item|
    next if item !~ bad_letters
    next if item !~ yelow_letters

    item =~ green_letters
  end

  puts words.to_s

  puts 'Якщо хочеш завершити роботу програми напиши 1'
  choice = $stdin.gets.to_i
end
