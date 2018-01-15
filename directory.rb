COHORTS = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    students << {name: name}
    puts "Now we have #{students.count} student#{students.count > 1 ? "s" : ""}"
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
  if students.length == 0
    puts "There are currently no students."
    return
  else
    students.each_with_index do |student, idx|
      puts "#{idx + 1}. #{student[:name].capitalize}".ljust(15, ".") +
           "#{student[:cohort].capitalize} cohort".rjust(10)
    end
    puts "\n"
  end
end

def print_cohorts(students)
  return if students.length == 0
  if students.length == 1
    puts "#{students[0][:name].capitalize} is from the #{students[0][:cohort].capitalize} cohort."
  else
    cohorts = {}
    students.map do |student|
      if cohorts[student[:cohort]]
        cohorts[student[:cohort]] << student[:name]
      else
        cohorts[student[:cohort]] = [student[:name]]
      end
    end
    cohorts.each do |cohort, names|
      last_name = names.slice(-1).capitalize
      names_for_print = names[0..-2].join(", ").capitalize + " and #{last_name}"
      puts "#{names_for_print} are from the #{cohort.capitalize} cohort."
    end
    puts "\n"
  end
end

def print_footer(students)
  return if students.length == 0
    puts "In total, we have #{students.count} great student#{students.count > 1 ? "s" : ""}."
    puts "\n"
end

def interactive_menu
  students = []
  loop do
    puts "1. Input students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit
    end
  # 1. Print the menu and ask the user what to do
  # 2. Read the input and save it into a variable
  # 3. Do what the user has asked
  end
end

interactive_menu
