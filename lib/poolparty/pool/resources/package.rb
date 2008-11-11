module PoolParty    
  module Resources
        
    class Package < Resource
      
      default_options({
        :ensure => "installed"
      })
      
      def disallowed_options
        [:name]
      end
      
      def present
        "installed"
      end
      def absent
        "absent"
      end
      
    end
    
  end
end