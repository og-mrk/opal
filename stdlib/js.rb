require 'js/raw'

warn '[Opal] JS module has been renamed to JS::Raw and will change semantics in Opal 2.0. ' \
     'In addition, you will need to require "js/raw" instead of "js". ' \
     'To ensure forward compatibility, please update your calls.'

module JS
  extend JS::Raw
end
