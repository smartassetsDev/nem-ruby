module Nem
  module Model
    class ExpelorerBlock
      include Nem::Mixin::Assignable

      attr_reader :difficulty, :txes, :block, :hash

      def self.new_from_explorer_block(hash)
        txes = hash[:txes].map do |tx|
          Transaction.new_from_account_transaction_meta_data_pair(
            meta: { hash: { data: tx[:hash] } },
            transaction: tx[:tx]
          )
        end
        new(
          difficulty: hash[:difficulty],
          txes: txes,
          block: Block.new_from_block(hash[:block]),
          hash: hash[:hash]
        )
      end
    end
  end
end
