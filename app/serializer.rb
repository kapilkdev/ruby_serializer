class Serializer

  class << self
    @@_attribute = {}

    def attribute(*attrs, &block)
      attrs.each do |attr|
        attr_hash[attr.to_s] ||= block_given? ? block : attr.freeze
      end
    end

    def attr_hash
      @@_attribute[self.name] ||= {}
    end
  end
end
