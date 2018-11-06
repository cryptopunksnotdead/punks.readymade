# encoding: utf-8

require 'pp'
require 'logger'


require 'csvreader'

## our own code
require 'csvhuman/version'    # note: let version always go first
require 'csvhuman/reader'



## add some "alternative" shortcut aliases
CsvHum  = CsvHuman
CSV_HXL = CsvHuman
CSVHXL  = CsvHuman
HXL     = CsvHuman



# say hello
puts CsvHuman.banner     if $DEBUG || (defined?($RUBYCOCO_DEBUG) && $RUBYCOCO_DEBUG)
