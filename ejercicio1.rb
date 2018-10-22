# El archivo casino.txt contiene las recaudaciones de 4 días de un casino separadas por
# mesa de juego.

# Mesa1, 90, 60, 10, 30
# Mesa2, 40, 34, 77, 11
# Mesa3, 34, 86, 55, 91
# Mesa4, 67, 93, 43, 87

# Se pide:
#     Crear una clase Table cuyo constructor reciba el nombre de la mesa y las
#     recaudaciones correspondientes de cada día.
    
#     Crear un método que permita leer el archivo e instanciar una mesa por línea del
#     archivo.

#     Crear métodos que permitan:
#         - Conocer el mayor valor recaudado, y a que mesa y día corresponde.
#         - Calcular el promedio total de lo recaudado por todas las mesas en todos los días

file_name = 'casino.txt'

class Read_casino
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

class Table 
    attr_reader :table
    attr_reader :cash_collection
    def initialize(table, *cash_collection)
        @table = table
        @cash_collection = cash_collection.map(&:to_i)  # A cada uno &: 
    end 
end    

def max_collection(tables)
    max_collection = []
    global_max = 0
    tables.each do |table|
        max_amt = 0
        max_day   = 0
        table.cash_collection.each_with_index do |amt, day|
            if amt > max_amt
                max_amt = amt
                max_day = day
            end 
        end     
        if max_amt > global_max
            max_collection = [table.table, max_day, max_amt]
            global_max = max_amt
        end
    end 
    return max_collection
end 

def avg_collection(tables)
    avg_collection = 0
    sum = 0
    i = 0
    tables.each do |table|
        sum += table.cash_collection.inject(:+)
        i += table.cash_collection.length    
    end
    avg_collection = sum / i.to_f
end 

casino = Read_casino.new(file_name)
line_split = casino.read_file

tables = []
line_split.each do |line|
    tables << Table.new(*line)
end     

max_coll = max_collection(tables)
avg_coll = avg_collection(tables)

puts "La máxima recaudación fue en la #{max_coll[0]}, con $ #{max_coll[2]} el día #{max_coll[1] + 1}"
puts "El promedio de recaudación es: #{avg_coll}"







