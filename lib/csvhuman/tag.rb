# encoding: utf-8

class CsvHuman



class Tag

  ##  1) plus (with optional hashtag and/or optional leading and trailing spaces)
  ##  2) hashtag (with optional leading and trailing spaces)
  ##  3) spaces only (not followed by plus) or
  ##   note: plus pattern must go first (otherwise "sector  + en" becomes ["sector", "", "en"])
  SEP_REGEX = /(?:  \s*\++
                        (?:\s*\#+)?
                    \s*  )
                   |
               (?:  \s*\#+\s*  )
                   |
               (?:  \s+)
              /x    ## check if \s includes space AND tab?



  def self.split( value )
    value = value.strip
    value = value.downcase
    while value.start_with?('#') do   ## allow one or more hashes
      value = value[1..-1]    ## remove leading #
      value = value.strip   ## strip (optional) leading spaces (again)
    end
    ## pp value
    parts = value.split( SEP_REGEX )

    ## sort attributes a-z
    if parts.size > 2
       [parts[0]] + parts[1..-1].sort
    else
      parts
    end
  end


  def self.normalize( value )   ## todo: rename to pretty or something or add alias
    parts = split( value )
    name       = parts[0]
    attributes = parts[1..-1]   ## note: might be nil

    buf = ''
    if name  ## note: name might be nil too e.g. value = "" or value = "   "
      buf << '#' + name
      if attributes && attributes.size > 0
        buf << ' +'
        buf << attributes.join(' +')
      end
    end
    buf
  end


  def self.guess_type( name, attributes )

    if name == 'date'
       Date
    ## todo/fix: add more well-known names with num required!!!
    elsif ['affected', 'inneed', 'targeted', 'reached', 'population'].include?( name )
       Integer
    else
      ## check attributes
      if attributes.nil? || attributes.empty?
        String  ## assume (default to) string
      elsif attributes.include?( 'num' ) ||
            attributes.include?( 'id')   ## assume id is (always) a rowid - why? why not?
        Integer
      elsif attributes.include?( 'date' )   ### todo/check: exists +date?
        Date
      elsif name == 'geo' && (attributes.include?('lat') ||
                              attributes.include?('lon') ||
                              attributes.include?('elevation'))
        Float
      elsif attributes.include?( 'killed' ) ||
            attributes.include?( 'injured' ) ||
            attributes.include?( 'infected' ) ||
            attributes.include?( 'displaced' ) ||
            attributes.include?( 'idps' ) ||
            attributes.include?( 'refugees' ) ||
            attributes.include?( 'abducted' ) ||
            attributes.include?( 'threatened' ) ||
            attributes.include?( 'affected' ) ||
            attributes.include?( 'inneed' ) ||
            attributes.include?( 'targeted' ) ||
            attributes.include?( 'reached' )
        Integer
      else
        String   ## assume (default to) string
      end
    end
  end



  def self.parse( value )
    parts = split( value )

    name       = parts[0]
    attributes = parts[1..-1]   ## todo/fix: check if nil (make it empty array [] always) - why? why not?
    type       = guess_type( name, attributes )

    new( name, attributes, type )
  end




  attr_reader :name
  attr_reader :attributes   ## use attribs or something shorter - why? why not?
  attr_reader :type

  def initialize( name, attributes=nil, type=String )
    @name       = name
    ## sorted a-z - note: make sure attributes is [] NOT nil if empty - why? why not?
    @attributes = attributes || []
    @type       = type         ## type class (defaults to String)
  end


  def key
    ## convenience short cut for "standard/default" string key
    ##   cache/pre-built/memoize - why? why not?
    ##  builds:
    ##   population+affected+children+f

    buf = ''
    buf << @name
    if @attributes && @attributes.size > 0
      buf << '+'
      buf << @attributes.join('+')
    end
    buf
  end

  def to_s
    ## cache/pre-built/memoize - why? why not?
    ##
    ##  builds
    ##     #population +affected +children +f

    buf = ''
    buf << '#' + @name
    if @attributes && @attributes.size > 0
      buf << ' +'
      buf << @attributes.join(' +')
    end
    buf
  end


  def typecast( value )   ## use convert or call - why? why not?
    if @type == Integer
      conv_to_i( value )
    elsif @type == Float
      conv_to_f( value )
    elsif @type == Date
      conv_to_date( value )
    else   ## assume String
      # pass through as is
      value
    end
  end


private
  def conv_to_i( value )
    if value.nil? || value.empty?
      nil   ## return nil - why? why not?
    else
      Integer( value )
    end
  end

  def conv_to_f( value )
    if value.nil? || value.empty?
      nil   ## return nil - why? why not?
    else
      ## todo/fix: add support for NaN, Inf, -Inf etc.
      ##    how to deal with conversion errors (throw exception? ignore? NaN? why? why not?)
      Float( value )
    end
  end

  def conv_to_date( value )
    if value.nil? || value.empty?
      nil   ## return nil - why? why not?
    else
      ## todo/fix: add support for more formats
      ##    how to deal with conversion errors (throw exception? ignore? why? why not?)
      Date.strptime( value, "%Y-%m-%d" )
    end
  end
end # class Tag


end # class CsvHuman
