#--
# Copyright (c) 2010-2011 Peter Horn, Provideal GmbH
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

require "active_support/hash_with_indifferent_access"

# We're extending the already dubious semantics of HashWithIndifferentAccess
# to raise errors if either an unset key is requested, or if a previously
# unset key is set by a merge.
#
# This is used to prevent usage of 'wrong' options.
class WhinyHash < ActiveSupport::HashWithIndifferentAccess
  def [](key)
    key?(key) ? super(key) : raise("Accessing unset key '#{key}'.")
  end
  
  def []=(key, val)
    key?(key) ? super(key, val) : raise("Trying to set previously unset key '#{key}'.")
  end
  
  alias_method :merge_lidsa, :merge
  def merge(other)
    other.keys.each do |k| 
      raise "Trying to override unset key '#{k}'." unless key?(k) 
    end
    WhinyHash.new(merge_lidsa(other))
  end
  
end
