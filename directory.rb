COHORTS = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input students"
  puts "2. Show the students"
  puts "3. Save the list of students"
  puts "4. Load the list of students from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    menu_feedback(selection)
    @students = input_students_names
    input_cohorts
    input_students_details
  when "2"
    menu_feedback(selection)
    show_students
  when "3"
    menu_feedback(selection)
    save_students
  when "4"
    menu_feedback(selection)
    load_students
  when "9"
    menu_feedback(selection)
    exit
  else
    menu_feedback
  end
end

def menu_feedback(selection = false)
  if selection
    puts "You have chosen option #{selection}"
  else
    puts "Please choose a number from the menu"
  end
end

def input_students_names
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    @students << {name: name}
    puts "Now we have #{@students.count} student#{@students.count > 1 ? "s" : ""}"
    name = STDIN.gets.chomp
  end
end

def input_cohorts
  @students.each do |student|
    get_cohort(student)
  end
end

def get_cohort(student)
  loop do
    puts "What cohort is #{student[:name]} from?"
    cohort = STDIN.gets.chomp.downcase.to_sym
    if COHORTS.include?(cohort)
      student[:cohort] = cohort
      break
    else
      puts "That is not a valid cohort"
    end
  end
end

def input_students_details
  puts "Please provide the height, nationality and gender of each student"
  @students.each do |student|
    get_student_details(student)
  end
end


def get_student_details(student)
  attributes = [:height, :nationality, :gender]
    attributes.each do |attribute|
      puts "what is #{student[:name]}'s #{attribute}?'"
      student[attribute] = STDIN.gets.chomp
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villians Academy".center(50)
  puts "§------------------------------------------------§".center(50)
end

def print_students_list
  if @students.length == 0
    puts "There are currently no students."
    return
  else
    @students.each_with_index do |student, idx|
      puts "#{idx + 1}. #{student[:name].capitalize}".ljust(15, ".") +
           "#{student[:cohort].capitalize} cohort".rjust(10)
    end
  end
end

def print_cohorts
  return if @students.length == 0
  if @students.length == 1
    puts "#{@students[0][:name].capitalize} is from the #{@students[0][:cohort].capitalize} cohort."
  else
    cohorts = {}
    @students.each do |student|
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
  end
end

def print_footer
  return if @students.length == 0
    puts "In total, we have #{@students.count} great student#{@students.count > 1 ? "s" : ""}."
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first ? ARGV.first : 'students.csv'
  if File.exists?(filename)
    load_students(filename)
  else
    puts "I'm afraid that file does not exist. Please use menu option 4 to try again"
  end
end

try_load_students
interactive_menu
