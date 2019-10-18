class Object
  def attribute(attribute, &block)

    attribute.is_a?(Hash) ? (attr, value = attribute.first) :
    (
      attr = attribute
      value = (block ? block : nil)
    )

    class_eval do

        define_method "#{attr}=" do |attr_value|
        instance_variable_set("@#{attr}", attr_value)
        end

        define_method "#{attr}" do
          unless instance_variable_get("@#{attr}")
            block_value = value.is_a?(Proc) ? instance_eval(&value) : value
            instance_variable_set("@#{attr}", block_value)
          end
        instance_variable_get("@#{attr}")
        end

        define_method("#{attr}?") do
        instance_variable_get("@#{attr}")? true : false
        end

    end
  end
end
