function count_helium(blocks::Vector{Int})
  left_wall::Int = 0
  zeros_counter::Vector{Int} = []
  capacity = 0
  for (i, block) in enumerate(blocks) # O(n)
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
    capacity = count_helium(blocks)
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