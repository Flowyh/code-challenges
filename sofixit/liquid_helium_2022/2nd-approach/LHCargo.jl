function truncate_trailing_zeros!(bits::Vector{BitVector})
  for vector in 1:length(bits)
    right_truncated = false
    while (!right_truncated)
      # Truncate right
      if (length(bits[vector]) == 0) break end
      if (!right_truncated && bits[vector][end] == false) 
        pop!(bits[vector])
      else 
        right_truncated = true
      end
    end
  end
end

function blocks_to_bits(blocks::Vector{Int})::Vector{BitVector}
  result = Vector{BitVector}(undef, 0)
  max_height = 0
  for block in blocks
    for i in 1:max_height
      if (block >= i)
        push!(result[i], 1)
      else
        push!(result[i], 0)
      end
    end
    new_height = false
    while (length(result) < block)
      push!(result, BitVector([1]))
      new_height = true
    end
    if (new_height) 
      max_height = block
    end
  end
  truncate_trailing_zeros!(result)
  return result
end

function count_helium(cargo::Vector{BitVector})
  capacity = 0
  for level in cargo
    for block in 2:length(level)-1
      if (!level[block])
        capacity += 1
      end
    end
  end
  return capacity
end

function usage()
  println("Usage: julia LHCargo.jl [comma separated numbers]")
  println("Example: julia LHCargo.jl \"1,2,3\"")
end

function main(args::Array{String})
  if (length(args) < 1)
    print("Please provide at least one command line argument.")
    usage()
    exit(1)
  end

  try
    blocks = map(x -> parse(Int, x), split(args[1], ","))
    cargo = blocks_to_bits(blocks)
    capacity = count_helium(cargo)
    println("Cargo capacity: $capacity")
  catch e
    println("Parsing error")
    println(e)
    exit(1)
  end
end

if abspath(PROGRAM_FILE) == @__FILE__
  main(ARGS)
end