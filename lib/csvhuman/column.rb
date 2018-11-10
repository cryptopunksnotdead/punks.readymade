# encoding: utf-8


class CsvHuman


class Columns


  def self.build( values )

    ## "clean" unify/normalize names
    tag_keys = values.map do |value|
      if value
        if value.empty?
          nil
        else
          ## e.g. #ADM1 CODE                      => #adm1 +code
          ##      POPULATION F CHILDREN AFFECTED  => #population +affected +children +f
          value = Tag.normalize( value )
          ## turn empty normalized tags (e.g. "stray" hashtag) into nil too
          value = nil   if value.empty?
          value
        end
      else  # keep (nil) as is
        nil
      end
    end


    counts = {}
    tag_keys.each_with_index do |key,i|
       if key
         counts[key] ||= []
         counts[key] << i
       end
    end
    ## puts "counts:"
    ## pp counts

    ## create all unique tags
    tags = {}
    counts.each_key do |key|
      tags[key] = Tag.parse( key )
    end
    ## puts "tags:"
    ## pp tags


    cols = []
    tag_keys.each do |key|
      if key
        count = counts[key]
        tag   = tags[key]    ## note: "reuse" tag for all columns if list
        if count.size > 1
          ## note: defaults to use "standard/default" tag key (as a string)
          cols << Column.new( tag.key, tag, list: true )
        else
          cols << Column.new( tag.key, tag )
        end
      else
        cols << Column.new
      end
    end

    cols
  end
end ## class Columns




class Column
   attr_reader  :key   # used for record (record key); note: list columns must use the same key
   attr_reader  :tag


   def initialize( key=nil, tag=nil, list: false )
     @key  = key
     @tag  = tag
     @list = list
   end


   def tagged?()  @tag.nil? == false; end
   def list?()    @list; end
end  # class Column

end # class CsvHuman
