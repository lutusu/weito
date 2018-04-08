module Teller
  module Objectify
    def fp_call(*procs)
      procs.inject(self){|result,fp_proc| fp_proc.call(result)}
    end
  end
end