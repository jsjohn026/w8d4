require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    output = DBConnection.execute2(<<-SQL)
    SELECT * 
    FROM #{table_name}
    SQL
    @columns = output.first.map { |c| c.to_sym }
  end

  def self.finalize!
      self.columns.each do |col|
        @attributes[col] = define_method(col) { self.instance_variable_get("@#{col}") }

        @attributes["#{col}="] = define_method("#{col}=") { |val| self.instance_variable_set("@#{col}", val) }
    end
  end

  def self.table_name=(table_name)
    @table_name =  table_name || self.name.tableize
  end
  
  def self.table_name
    # @table_name.nil? ? self.name.tableize : @table_name #also works
    @table_name =  @table_name || self.name.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
