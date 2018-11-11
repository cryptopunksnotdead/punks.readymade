# encoding: utf-8


class CsvHuman

HEADER_CONVERTERS = {
 ## e.g.  "#adm1 +code"  =>  "#adm1 +code"
 none:      ->(value) { value },

 ## e.g.  "#adm1 +code"  =>  "adm1+code"   (strip hashtags and whitespace)
 default:   ->(value) { value.downcase.gsub('#', '').
                                       gsub( /\s+/, '' ) },

 ## e.g.  "#adm1 +code"  =>  :adm1_code"   (strip hashtags and whitespace and turn plus (+) into underscore (_))
 symbol:    ->(value) { value.downcase.gsub('#', '').
                                       gsub( /\s+/, '' ).
                                       gsub('+', '_').
                                       gsub( /[^\w]+/, '' ).to_sym }
}

end # class CsvHuman
