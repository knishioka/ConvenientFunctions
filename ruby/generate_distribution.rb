def gaussian(mean = 0, sigma = 1)
  sum = 0.0
  12.times { sum += rand() }
  return (sum - 6) * sigma + mean
end
