module Git
  class Branch

    def checkout(opts = {})
      check_if_create unless opts[:new_branch]
      @base.checkout(@full, opts)
    end

    # New method.
    def move(branch)
      @base.branch_move_to(branch)
    end

  end
end
