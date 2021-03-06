module QC
  module Setup
    Root = File.expand_path("../..", File.dirname(__FILE__))
    SqlFunctions = File.join(Root, "/sql/ddl.sql")
    CreateTable = File.join(Root, "/sql/create_table.sql")
    DropSqlFunctions = File.join(Root, "/sql/drop_ddl.sql")

    def self.create(c=nil)
      conn = QC::ConnAdapter.new(c)
      conn.execute(File.read(CreateTable))
      conn.execute(File.read(SqlFunctions))
      conn.disconnect if c.nil? #Don't close a conn we didn't create.
    end

    def self.drop(c=nil)
      conn = QC::ConnAdapter.new(c)
      conn.execute("DROP TABLE IF EXISTS queue_classic_jobs CASCADE")
      conn.execute(File.read(DropSqlFunctions))
      conn.disconnect if c.nil? #Don't close a conn we didn't create.
    end
  end
end
