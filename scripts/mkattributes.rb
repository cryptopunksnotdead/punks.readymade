# encoding: utf-8

require 'csvreader'



def linkify_attribute( attribute )
  "[`+#{attribute}`](##{attribute})"
end


ATTRIBUTE_RX = /
               \#[a-z][a-z0-9]*
             /x


def linkify_attributes( line )
  ## note: assumes +f etc. (that is, includes leading plus)
  line.gsub( ATTRIBUTE_RX ) do |attrib|
    puts "linkify attribute >#{attrib}<"
    "[`#{attrib}`](##{attrib[1..-1]})"  ## note: cut-of leading + in intralink
  end
end



def build_summary( attributes )
  pp attributes

  attributes_a_to_z = attributes.sort { |l,r|  l['attribute'] <=> r['attribute'] }
  pp attributes_a_to_z


  buf = ""
  buf << "# Humanitarian eXchangle Language (HXL) Attributes\n\n"

  attributes_a_to_z.each do |attribute|
    buf << linkify_attribute( attribute['attribute'])
    buf << "\n"
  end

  buf << "\n\n"



  last_category = nil

  attributes.each do |attribute|

    if attribute['category'] != last_category
      buf << "## #{attribute['category']}\n\n"
    end

    buf << "### `+#{attribute['attribute']}`\n\n"
    buf << "#{linkify_attributes(attribute['description'])} _Since version #{attribute['since']}_\n\n"

    unless attribute['tags'].empty?
      buf << "Tags: `#{attribute['tags']}`\n\n"
    end


    last_category = attribute['category']
  end

  buf
end


## pp Csv.read( "./config/attributes.csv" )

attributes = CsvHash.read( "./config/attributes.csv" )

buf = build_summary( attributes )
puts buf

File.open( "./ATTRIBUTES.md", 'w:utf-8') do |f|
  f.write( buf )
end
