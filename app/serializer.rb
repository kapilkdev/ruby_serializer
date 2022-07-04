class Serializer
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def serialize
    data = {}

    @@_attribute[self.class.name].each do |key, attr|
      data[key.to_sym] ||= if attr.is_a?(Symbol)
                              object.send(attr)
                            else
                              instance_eval(&attr)
                            end
    end

    data
  end

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
