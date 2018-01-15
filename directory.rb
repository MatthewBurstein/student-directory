COHORTS = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    students << {name: name}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  input_cohorts(students)
  input_student_details(students)
end

def input_cohorts(students)
  students.each do |student|
    cohort = ""
    while !COHORTS.include?(cohort)
      puts "What cohort is #{student[:name]} from?"
      cohort = gets.chomp.downcase.to_sym
      if COHORTS.include?(cohort)
        student[:cohort] = cohort
        next
      else
        puts "That is not a valid cohort."
      end
    end
  end
end


def input_student_details(students)
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
    puts "#{idx + 1}. #{student[:name].capitalize}".ljust(15, ".") +
         "#{student[:cohort].capitalize} cohort".rjust(10)
  end
  puts "\n"
end

def print_footer(students)
    puts "Overall, we have #{students.count} great student#{students.count > 1 ? "s" : ""}."
    puts "\n\n"
end

students = input_students
print_header
print(students)
print_footer(students)
