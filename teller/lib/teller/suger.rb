module Teller
  module Suger
    def self.chain(*procs)
      ->(arg){procs.inject(arg){|arg,fp_proc|fp_proc.(arg)}}
    end
  end
end