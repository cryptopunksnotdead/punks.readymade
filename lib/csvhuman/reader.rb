# encoding: utf-8


class CsvHuman

## Q: how to deal with un-tagged fields?
##     - skip / ignore
## Q: how to deal duplicate fields (e.g. #sex+#targeted,#sex+#targeted)?
##     - value (auto-magically) turned into an array / list


    def self.open( path, mode=nil, &block )   ## rename path to filename or name - why? why not?

     ## note: default mode (if nil/not passed in) to 'r:bom|utf-8'
     ## f = File.open( path, mode ? mode : 'r:bom|utf-8' )
     csv = Csv.open( path, mode, parser: Csv::Parser.human )     ## note: returns an enumarator-like object
     human = new( csv )

     # handle blocks like Ruby's open(), not like the (old old) CSV library
     if block_given?
       begin
         block.call( human )
       ensure
         csv.close
       end
     else
       human
     end
 end # method self.open


    def self.read( path )
        open( path ) { |human| human.read }
    end


    def self.foreach( path, &block )
          csv = Csv.open( path, parser: Csv::Parser.human )     ## note: returns an enumarator-like object
          human = new( csv )

          if block_given?
            begin
              human.each( &block )
            ensure
              csv.close
            end
          else
            human.to_enum    ## note: caller (responsible) must close file!!!
            ## remove version without block given - why? why not?
            ## use Csv.open().to_enum  or Csv.open().each
            ##   or Csv.new( File.new() ).to_enum or Csv.new( File.new() ).each ???
          end
    end # method self.foreach


    def self.parse( str_or_readable, &block )
          human = new( str_or_readable )

          if block_given?
            human.each( &block )  ## note: caller (responsible) must close file!!! - add autoclose - why? why not?
          else  # slurp contents, if no block is given
            human.read            ## note: caller (responsible) must close file!!! - add autoclose - why? why not?
          end
    end # method self.parse




class Column
   attr_reader  :tag

   def initialize( tag=nil, list: false )
     @tag  = tag
     @list = list
   end

   def tagged?()  @tag.nil? == false; end
   def list?()    @list; end
end  # class Column



attr_reader :header, :tags

def initialize( recs_or_stream )
   ## todo/check:  check if arg is a stream/enumarator - why? why not??
   if recs_or_stream.is_a?( String )
     @recs = Csv.new( recs_or_stream, parser: Csv::Parser.human )     ## note: returns an enumarator-like object
   else
     @recs = recs_or_stream
   end

   @header = []
   @tags   = nil   ## add tags = nil  -- why? why not?
   @cols   = nil   ## column mappings (used "internally")
end


include Enumerable

def each( &block )
  @header = []
  @tags   = nil   ## add tags = nil  -- why? why not?
  @cols   = nil   ## column mappings (used "internally")

  @recs.each do |values|
    ## pp values
    if @cols.nil?
      if values.any? { |value| value && value.start_with?('#') }
        @cols = build_cols( values )
        @tags = values
      else
        @header << values
      end
    else

      ## data row
      ##  strip non-tagged - how?
      record = {}
      @cols.each_with_index do |col,i|
        if col.tagged?
          key   = col.tag
          value = values[i]
          if col.list?
            record[ key ] ||= []
            record[ key ] << value
          else
            ## add "regular" single value
            record[ key ] = value
          end
        end
      end
      ## pp record
      block.call( record )
    end
  end
end  # method each

def read() to_a; end # method read


###
### todo/fix:
##   add closed? and close
##    if self.open used without block (user needs to close file "manually")


####
# helpers


def build_cols( values )

  ## "clean" unify/normalize names
  values = values.map do |value|
    if value
      if value.empty?
        nil     ## make untagged fields nil
      else
        ## todo: sort attributes by a-to-z
        ##  strip / remove all spaces
        value.strip.gsub('#','')   ## remove leading # - why? why not?
      end
    else
      value   ## keep (nil) as is
    end
  end


  counts = {}
  values.each_with_index do |value,i|
     if value
       counts[value] ||= []
       counts[value] << i
     end
  end
  ## pp counts


  cols = []
  values.each do |value|
    if value
      count = counts[value]
      if count.size > 1
        cols << Column.new( value, list: true )
      else
        cols << Column.new( value )
      end
    else
      cols << Column.new
    end
  end

  cols
end

end # class CsvHuman
