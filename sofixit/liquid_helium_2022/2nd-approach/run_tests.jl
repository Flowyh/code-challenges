include("./LHCargo.jl")
include("../tests.jl")

"""
Run test units and assert computed capacity with expected values.
"""
function run_tests()
  for test in Tests
    println("Test: $test")
    cargo = blocks_to_bits(test.blocks)
    @assert test.expected_capacity == count_helium(cargo)
    println("Test passed!")
  end
end

"""
Main program function.
"""
function main(args::Array{String})
  run_tests()
end

# Equivalent of Python's if __name__ == "__main__".
if abspath(PROGRAM_FILE) == @__FILE__
  main(ARGS)
end
