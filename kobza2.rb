# Метод яким порівнюється слово з фільтром зелених букв.
def check_green_letters?(word, letters)
  word.each.with_index do |w, index|
    next if letters[index]

    return false if w != letters[index]
  end

  true
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
green_letters = [nil, nil, 'м', 'і', nil]
yelow_letters = 'міа'.chars
bad_letters = /.*/

# залишає слова яка дають true по всіх 3ьох умовах
words.select! do |item|
#  next if item =~ bad_letters
  next if (yelow_letters - item.chars).any?

  check_green_letters?(item.chars, green_letters) # звіряє букви слова та зелені букви
end

puts words
