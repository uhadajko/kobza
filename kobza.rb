# Метод яким порівнюється слово з фільтром зелених букв.
def check_green_letters?(word, letters)

  index = -1

  word.each do |w|
    index += 1
    next if letters[index] == nil
    return false if w != letters[index]
  end
end

if File.exist?('data/words.txt')
  f = File.new('data/words.txt', 'r:UTF-8')
  words = f.readlines
  f.close

  # Видалимо всі лишні слова, більше і менше 5 символів
  words.delete_if { |item| (item.length > 6) || (item.length < 6) || item =~ /-.,/ }
else
  puts 'файл відсутній'
  exit
end

words.each { |item| item.chomp!.downcase! }

# задаємо фільтри
# треба фільтр вносити з консолі, потім навчусь працювати з кодіровками
green_letters = [nil, nil, "м", 'і', nil]
#green_letters = /..мі./
yelow_letters = 'амі'.chars
bad_letters = 'штихря'.chars

words.select! do |item|
  next if (bad_letters & item.chars).any?
  next if (yelow_letters - item.chars).any?
  check_green_letters?(item.chars, green_letters) # звіряє букви слова та зелені букви
end

puts words
