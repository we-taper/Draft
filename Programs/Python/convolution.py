import numpy as np

# given two bernoulli distribution
a1 = np.array([0.3,0.7])
a2 = np.array([0.3,0.7])

# return their convolution
col = np.convolve(a1,a2,'full') # full: This returns the convolution at each point of overlap
print(col)
# which should equal to a Binomial Distribution (n=2,p=0.7)
print(np.isclose(col,[0.09,0.42,0.49]).all())

# Now for two measurements with different possible outcomes
p1 = [0.4,0.6]
p2 = [0.4,0.6]

q1 = [0.6,0.4]
q2 = [0.6,0.4]

suc = 1/2 * p1[1] + 1/2 * q1[0]

colp = np.convolve(p1,p2,'full')
colq = np.convolve(q1,q2,'full')

suc_2time = 1/2 * colp[2] + 1/2 * colq[0]

print('suc rate:'+str(suc))
print('suc_2time:'+str(suc_2time))
