=begin rdoc
  Base dependency_resolver
=end
module PoolParty
  module DependencyResolvers
    
    class Base
            
      def self.compile(resources=[])
        case resources
        when Array
          compile_array(resources)
        when PoolParty::Resource
          compile_resource(resources)
        end
      end
      
      # The name of the method that the resource
      # should respond to to compile
      # Format:
      #   print_to_<dependency_resolver.name>
      def self.compile_method_name
        @compile_method_name ||= "print_to_#{name.to_s.top_level_class}".to_sym
      end
      
      private
      
      def self.compile_resource(res)
        po = ProxyObject.new(res)
        po.compile(compile_method_name)
      end
      
      # Compile an array of resources
      def self.compile_array(array_of_resources=[])
        out = []
        array_of_resources.each do |res|          
          if res.respond_to?(compile_method_name)
            po = ProxyObject.new(res)
            out << po.compile(compile_method_name)
          end
        end
        out.join("\n")
      end
      
    end
    
  end
end