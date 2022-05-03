include("./LHCargo.jl")
include("../tests.jl")

function run_tests()
  for test in Tests
    println("Test: $test")
    cargo = test.blocks
    @assert test.expected_capacity == count_helium(cargo)
    println("Test passed!")
  end
end

function main(args::Array{String})
  run_tests()
end

if abspath(PROGRAM_FILE) == @__FILE__
  main(ARGS)
end
