# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_tags.rb


require 'helper'

class TestTags < MiniTest::Test


def test_split
  assert_equal [], split( "" )   # empty

  assert_equal ["sector", "en"], split( "#sector+en" )
  assert_equal ["sector", "en"], split( "#SECTOR EN" )
  assert_equal ["sector", "en"], split( "  # SECTOR  + EN " )

  assert_equal ["adm1", "code"], split( "#ADM1 +CODE" )
  assert_equal ["adm1", "code"], split( " # ADM1 + CODE" )
  assert_equal ["adm1", "code"], split( "ADM1 CODE" )

  ## sort attributes a-to-z
  assert_equal ["affected", "children", "f"], split( "#affected +f +children" )
end



private

##  1) plus (with optional leading and trailing spaces)
##  2) spaces only (not followed by plus) or
##   note: plus pattern must go first (otherwise "sector  + en" becomes ["sector", "", "en"])
SEP_REGEX = /(?:  \s*\+\s*  )
                 |
             (?:  \s+)
            /x    ## check if \s includes space AND tab?


def split( tag )
  tag = tag.strip
  tag = tag.downcase
  if tag.start_with?('#')
    tag = tag[1..-1]    ## remove leading #
    tag = tag.strip   ## strip (optional) leading spaces (again)
  end
  ## pp tag
  parts = tag.split( SEP_REGEX )

  ## sort attributes a-z
  if parts.size > 2
    [parts[0]] + parts[1..-1].sort
  else
    parts
  end
end


end # class TestTags
