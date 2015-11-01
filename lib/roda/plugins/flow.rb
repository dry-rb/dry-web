# this is taken from roda-flow plugin but it drops dependency on roda-container
class Roda
  module RodaPlugins
    module Flow
      module RequestMethods
        def resolve(*args, &block)
          on(resolve: args, &block)
        end

        private

        def match_resolve(resolve)
          Array(resolve).flatten.each do |key|
            @captures << roda_class.resolve(key)
          end
        end

        def match_to(to)
          container_key, @block_method = to.to_s.split('#')
          @block_arg = roda_class.resolve(container_key)
        end

        def match_inject(inject)
          @block_arg = @block_arg.call(*inject) if @block_arg
        end

        def match_call_with(call_with)
          @captures.concat(call_with)
        end

        def if_match(*args, &block)
          path = @remaining_path
          # For every block, we make sure to reset captures so that
          # nesting matchers won't mess with each other's captures.
          @captures.clear

          return unless match_all(args)
          block_result(get_block(&block).call(*captures))
          throw :halt, response.finish
        ensure
          @remaining_path = path
        end

        def always(&block)
          super(&get_block(&block))
        end

        def get_block(&block)
          if block_given?
            block
          elsif @block_arg
            if @block_method
              block_arg = @block_arg.method(@block_method)
            else
              block_arg = @block_arg
            end
            clear_block_args
            block_arg
          end
        end

        def clear_block_args
          @block_arg = nil
          @block_method = nil
        end
      end
    end

    register_plugin(:flow, Flow)
  end
end
