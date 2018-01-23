import numpy as np

# given two bernoulli distribution
a1 = np.array([0.3,0.7])
a2 = np.array([0.3,0.7])

# return their convolution
col = np.convolve(a1,a2,'full') # full: This returns the convolution at each point of overlap
print(col)
# which should equal to a Binomial Distribution (n=2,p=0.7)
print(np.isclose(col,[0.09,0.42,0.49]).all())
