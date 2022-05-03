"""
    count_helium(cargo)
  
Get liquid helium capacity in cargo unit.

Algorithm goes as follows:
- for each block in cargo's blocks:
  - if given `block` is taller than current max (`left_wall`):
    - `left_wall` <- `block`,
    - add new counters to `zeros_counter` until `length(zeros_counter) != left_wall`.
  - for i from 1 to `left_wall`
      - if i is larger than given block's height, it means that there is free space, which we can potentially use as helium storage
        - increment corresponding i-th `zeros_counter`
      - if i is smaller or equal to given block's height, it means we've found a right wall:
        - add i-th zeros_counter to overall capacity, as it is the counter of free cells between `left_wall` and current block's i-th level
        - reset i-th zeros_counter

More explanation can be found in README.md

# Params:

- `cargo::Vector{Int}`: list of consequent blocks' heights in cargo unit.

# Returns:

- `capacity::Int` - cargo unit's capacity

# Examples:
```jldoctest
julia> count_helium([4,0,2,3,1])
4
julia> count_helium([0,0,0,1])
0
```
"""
function count_helium(cargo::Vector{Int})
  left_wall::Int = 0
  zeros_counter::Vector{Int} = []
  capacity::Int = 0
  for (i, block) in enumerate(cargo) # O(n)
    if (length(zeros_counter) < block)
      left_wall = block
      while (length(zeros_counter) < block) push!(zeros_counter, 0) end # O(k)
    end
    for i in 1:left_wall # O(k)
      if (i > block)
        zeros_counter[i] += 1
      else
        capacity += zeros_counter[i]
        zeros_counter[i] = 0
      end
    end
  end
  return capacity
end

"""
    usage()

Print usage message.
"""
function usage()
  println("Usage: julia LHCargo.jl [comma separated numbers]")
  println("Example: julia LHCargo.jl \"1,2,3\"")
end

"""
Main program function.
"""
function main(args::Array{String})
  if (length(args) < 1)
    print("Please provide at least one command line argument.")
    usage()
    exit(1)
  end

  try
    blocks = map(x -> parse(Int, x), split(args[1], ","))
    capacity = count_helium(blocks)
    println("Cargo capacity: $capacity")
  catch e
    println("Parsing error")
    println(e)
    exit(1)
  end
end

# Equivalent of Python's if __name__ == "__main__".
if abspath(PROGRAM_FILE) == @__FILE__
  main(ARGS)
end