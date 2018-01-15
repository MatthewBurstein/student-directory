def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end

  puts "Please provide a little more information:"
  students.each do |student|
    puts "What is #{student[:name]}'s height in cm?"
    student[:height] = gets.chomp.to_i
    puts "What is #{student[:name]}'s nationality?"
    student[:nationality] = gets.chomp.to_sym
    puts "What are #{student[:name]}'s hobbies? (please separate hobbies with commas)"
    student[:hobbies] = gets.split(",").each { |hobby| hobby.strip!}
  end
end


def print_header
  puts "\n\n"
  puts "The students of Villians Academy".center(50)
  puts "§------------------------------------------------§".center(50)
  puts "\n"
end

def print(students)
  students.each_with_index do |student, idx|
    puts "#{idx + 1}. #{student[:name]}".ljust(15, ".") +
         "#{student[:cohort]} cohort".rjust(10)
  end
  puts "\n"
end

def print_footer(students)
    puts "Overall, we have #{students.count} great students"
    puts "\n\n"
end

students = input_students
print_header
print(students)
print_footer(students)
