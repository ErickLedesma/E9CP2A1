# El archivo cursos.txt contiene las fechas de inicio y término de cursos dictados por
# Desafío Latam durante el año 2017, con la siguiente estructura:

# Front-end, 2017-05-21, 2017-08-10
# Wordpress, 2017-04-12, 2017-11-04
# Full-stack, 2017-07-09, 2017-12-29
# Android, 2017-05-17, 2017-08-13
# Marketing, 2017-03-14, 2017-10-20

# Se pide:
#     Crear una clase Course cuyo constructor reciba el nombre y las fechas de inicio y
#     termino de cada curso.

#     Crear un método que permita leer el archivo e instanciar un curso por línea del
#     archivo.

#     Crear métodos que permitan:
#         - Saber qué cursos comienzan previo a una fecha entregada como argumento.
#         - Saber qué cursos finalizan posterior a una fecha entregada como argumento.
    
#         En ambos el métodos argumento por defecto debe ser la fecha de hoy.
#         Ambos métodos deben levantar una excepción si la fecha recibida es >= 2018-01-01.

require "date"

file_name = 'curso.txt'

class Read_courses
    attr_accessor :file_name
    def initialize(file_name) 
        @file_name = file_name
    end    

    def read_file
        file = File.open(@file_name, 'r')
        data = file.readlines
        file.close
        line_split = []
        data.each do |line|
            line_split << line.chomp.split(', ')
        end     
        return line_split
    end 
end 

class Course 
    attr_reader :course, :course_begin, :course_end
    def initialize(course, course_begin, course_end)
        @course = course
        @course_begin = Date.parse(course_begin)  
        @course_end   = Date.parse(course_end) 
    end
    def begins_before(reference_date)
        raise ArgumentError.new('reference date has wrong format')  if reference_date.class != Date 
        raise ArgumentError.new('reference date is higer 2018-01-01') if reference_date >= Date.parse('2018-01-01')
        @course_begin < reference_date 
    end 
    def ending_after(reference_date)
        raise ArgumentError.new('reference date has wrong format') if reference_date.class != Date     
        raise ArgumentError.new('reference date is higer 2018-01-01') if reference_date >= Date.parse('2018-01-01')
        @course_end > reference_date 
    end          
end  

file_courses = Read_courses.new(file_name)
line_split = file_courses.read_file

courses = []
line_split.each do |line|
    courses << Course.new(*line)
end     

puts 'Todos los Cursos'
courses.each do |course| 
    puts "Curso: #{course.course}  inicia el #{course.course_begin} y termina el #{course.course_end}"
end 

puts "\nCursos que inician antes del 30 de abril del 2017"
reference_date = Date.parse("2017-04-30")
courses.select { |course| course.begins_before(reference_date) }.each do |course|
    puts "Curso: #{course.course}  inicia el #{course.course_begin} y termina el #{course.course_end}"
end 

puts "\nCursos que finalizan despues del primero de noviembre del 2017"
reference_date = Date.parse("2017-11-01")
courses.select { |course| course.ending_after(reference_date) }.each do |course|
    puts "Curso: #{course.course}  inicia el #{course.course_begin} y termina el #{course.course_end}"
end 
