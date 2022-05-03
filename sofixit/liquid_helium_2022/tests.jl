struct CargoUnit
  blocks::Vector{Int}
  expected_capacity::Int
end

const Tests = Vector{CargoUnit}([
  CargoUnit([1,0,4,0,2,3], 5),
  CargoUnit([4,0,8,2,1,0], 4),
  CargoUnit([4,0,8,1,2,3], 7),
  CargoUnit([1,2,3,4,5,6], 0),
  CargoUnit([0,0,0,0,0,0,0,0,0,0,0], 0),
  CargoUnit([0,0,0,0,0,0,0,0,0,0,1], 0),
  CargoUnit([5,0,0,0,0,0,0,0,0,0,0], 0),
  CargoUnit([1,0,0,0,0,0,0,0,0,0,1], 9),
  # Sofixit tests:
  CargoUnit([0,1,0,2,1,0,1,3,2,1,2,1], 6),
  CargoUnit([0,1,0,2,1,0,3,1,0,1,2], 8),
  CargoUnit([4,2,0,3,2,5], 9),
  CargoUnit([6,4,2,0,3,2,0,3,1,4,5,3,2,7,5,3,0,1,2,1,3,4,6,8,1,3], 83)
])