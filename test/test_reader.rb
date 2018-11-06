# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_reader.rb


require 'helper'

class TestReader < MiniTest::Test

def recs
   [["Organisation", "Cluster", "Province" ],
     [ "#org", "#sector", "#adm1" ],
     [ "Org A", "WASH", "Coastal Province" ],
     [ "Org B", "Health", "Mountain Province" ],
     [ "Org C", "Education", "Coastal Province" ],
     [ "Org A", "WASH", "Plains Province" ]]
end

def txt
  <<TXT
  What,,,Who,Where,For whom,
  Record,Sector/Cluster,Subsector,Organisation,Country,Males,Females,Subregion
  ,#sector+en,#subsector,#org,#country,#sex+#targeted,#sex+#targeted,#adm1
  001,WASH,Subsector 1,Org 1,Country 1,100,100,Region 1
  002,Health,Subsector 2,Org 2,Country 2,,,Region 2
  003,Education,Subsector 3,Org 3,Country 2,250,300,Region 3
  004,WASH,Subsector 4,Org 1,Country 3,80,95,Region 4
TXT
end


def test_readme
  csv = CsvHuman.new( recs )
  csv.each do |rec|
    pp rec
  end

  pp csv.read
  pp CsvHuman.parse( recs )

  CsvHuman.parse( recs ).each do |rec|
    pp rec
  end


  pp CsvHuman.read( "#{CsvHuman.test_data_dir}/test.csv" )
  pp CsvHuman.parse( txt )
  CsvHuman.parse( txt ).each do |rec|
    pp rec
  end

  CsvHuman.foreach( "#{CsvHuman.test_data_dir}/test.csv" ) do |rec|
    pp rec
  end
end

end # class TestReader
