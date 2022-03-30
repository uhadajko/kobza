# Метод яким порівнюється слово з фільтром зелених букв.
if File.exist?('data/words.txt')
  f = File.new('data/words.txt', 'r:UTF-8')
  words = f.readlines
  f.close

  # Видалимо всі лишні слова, більше і менше 5 символів, та тіщо містять хочаб один символ [.,-]
  words.delete_if { |item| (item.length > 6) || (item.length < 6) || item =~ /[.,-]+/ }
else
  puts 'файл відсутній'
  exit
end

words.each { |item| item.chomp!.downcase! }

# прописуємо зелені букви на своїх місцях, решта ставимо крапки
green_letters = /...../

# потрібно в кожні квадратні лапки писати всі жовті тазелені букви,
# в залежності від кількості букв потрібно таку ж кількість лапок.
# цей метод не працює і потребує доопрацювання
yelow_letters = /.*[а].*/

# прописуємо всі чорні букви, окрім тих що вже є зеленими!
bad_letters = /[^ ]{5}/

words.select! do |item|
  next if not(item =~ bad_letters)
  next if not(item =~ yelow_letters)
  item =~ green_letters 
end

puts words
