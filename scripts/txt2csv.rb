require 'pp'


HASHTAG_LINE_RX= /^
                   \s*
                   \#
                   (?<name>[a-z][a-z0-9]+)
                   \s*
                   $/x

## note: attrib might be one letter only (e.g.) +m,+f, etc.
ATTRIB_LINE_RX= /^
                   \s*
                   \+
                   (?<name>[a-z][a-z0-9]*)
                   \s*
                   $/x

##
## e.g. 2.1. Sex- and-age disaggregation (SADD) attributes
##      1.1. Places

HEADING_LINE_RX=/^
                   \s*
                   (?<level1>[1-9])
                     \.
                   (?<level2>[1-9])
                     \.
                     \s+
                    (?<title>.+?)
                     \s*
                   $/x



def match_heading( line )
  if (m=HEADING_LINE_RX.match(line))
    puts "heading #{m[:level1]}.#{m[:level2]}. (#{m[:level2]}) >#{m[:title]}<"
    m
  else
    false
  end
end

def match_hashtag( line )
   if (m=HASHTAG_LINE_RX.match(line))
     puts "hashtag >#{m[:name]}<"
     m
   else
     nil
   end
end


def match_attrib( line )
   if (m=ATTRIB_LINE_RX.match(line))
     puts "attrib >#{m[:name]}<"
     m
   else
     false
   end
end


TYPE_RX = /Every value must be a (?<type>[a-z]+)./
def match_type( line )
  if (m=TYPE_RX.match(line))
    puts "type: >#{m[:type]}<"
    m
  else
    false
  end
end


SINCE_HXL_RX = /Since HXL (?<version>[1]\.[0-9])\.?/
def match_since_hxl( line )
  if (m=SINCE_HXL_RX.match(line))
    puts "version: >#{m[:version]}<"
    m
  else
    false
  end
end



def split_descr( line )
  if( m=match_since_hxl( line ))
    version = m[:version]
    ## remove "Since HXL 1.0" from text
    text    = line.gsub( SINCE_HXL_RX, '' ).strip
  else
    version = '?'
    text = line
  end
  [text,version]
end




def csv_row( *values )
  values.map do |value|
     if value && (value.index(",") || value.index('"'))
       ## double quotes and enclose in double qoutes
       value = %Q{"#{value.gsub('"', '""')}"}
     else
       value
     end
  end
end





def parse_attribs( txt )

attr     = nil
category = nil
descr    = nil
version  = nil
tags     = []


next_line   =  nil   ## e.g. set to :descr


attribs = []

txt.each_line do |line|
  line = line.chomp( '' )

  line = line.strip   ## remove leading and trailing spaces


  next if line.empty?  ## skip blank lines


  if next_line == :descr
    ## auto-capture next line (if descr reset to nil)
    descr, version = split_descr( line )
    puts "descr >#{descr}<, version >#{version}<"

    next_line = nil
  elsif (m=match_heading( line ))
    category = "(#{m[:level2]}) #{m[:title]}"
  elsif (m=match_attrib( line ))
     if attr
       attribs << csv_row( attr, version, category, tags.join( ' ' ), descr )
     end

    attr  = m[:name]
    tags  = []
    next_line = :descr  ## reset descr to nil - will auto-capture next line
  elsif (m=match_hashtag( line ))
    tags << "##{m[:name]}"
  end
end

if attr
  attribs << csv_row( attr, version, category, tags.join( ' ' ), descr )
end


attribs
end





def parse_tags( txt )

tag     = nil
type    = nil
category = nil
descr    = nil
version  = nil
attribs  = []

next_line   =  nil   ## e.g. set to :descr


tags = []

txt.each_line do |line|
  line = line.chomp( '' )

  line = line.strip   ## remove leading and trailing spaces


  next if line.empty?  ## skip blank lines


  if next_line == :descr
    ## auto-capture next line (if descr reset to nil)
    descr, version = split_descr( line )

    ## descr = "(2) People and households"   if descr == "(2) Surveys and assessments"

    puts "descr >#{descr}<, version >#{version}<"

    next_line = nil
  elsif (m=match_heading( line ))
    category = "(#{m[:level2]}) #{m[:title]}"
  elsif (m=match_type( line ))
    type = m[:type]
  elsif (m=match_hashtag( line ))
     if tag
       tags << csv_row( tag, type, version, category, attribs.join( ' ' ), descr )
     end

    tag      = m[:name]
    attribs  = []
    type     = nil
    next_line = :descr  ## reset descr to nil - will auto-capture next line
  elsif (m=match_attrib( line ))
    attribs << "+#{m[:name]}"
  end
end

if tag
  tags << csv_row( tag, type, version, category, attribs.join( ' ' ), descr )
end


tags
end




txt = File.open( "./attributes.txt", 'r:utf-8').read
attribs = parse_attribs( txt )
pp attribs

File.open( "./attributes.csv", 'w:utf-8') do |f|
 f.write ["attribute","since","category","tags","description"].join(",")
 f.write "\n"
 attribs.each do |attrib|
   f.write attrib.join(",")
   f.write "\n"
 end
end


txt = File.open( "./tags.txt", 'r:utf-8').read
tags = parse_tags( txt )
pp tags

File.open( "./tags.csv", 'w:utf-8') do |f|
 f.write ["tag", "type", "since", "category", "attributes", "description"].join(",")
 f.write "\n"
 tags.each do |tag|
  f.write tag.join(",")
  f.write "\n"
 end
end
