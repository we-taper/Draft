"""
Coin tossing experiment

"""

import numpy as np


pm1is1 = 0.9
pm1is0 = 0.1

pm2is1_m1is0 = 0.45
pm2is0_m1is0 = 0.55

pm2is1_m1is1 = 0.56
pm2is0_m1is1 = 0.44

repeat = 1000

print(__file__)
def toss_coin(repeat, prob_of_up):
    tmp = np.random.uniform(low=0, high=1, size=repeat)
    tmp = tmp < prob_of_up
    return tmp.astype(int)

def test_for_repeat(repeat):
    m1 = toss_coin(repeat=repeat, prob_of_up=pm1is1)
    num_m1is1 = np.count_nonzero(m1)

    m2 = np.empty_like(m1)
    m2[m1==1] = toss_coin(repeat=num_m1is1, prob_of_up=pm2is1_m1is1)
    m2[m1==0] = toss_coin(repeat=repeat-num_m1is1, prob_of_up=pm2is1_m1is0)

    out = m1*2+m2
    out += 1
    unique, count = np.unique(out, return_counts=True)
    # print([unique, count])
    expected = [pm1is0*pm2is0_m1is0, pm1is0*pm2is1_m1is0, pm1is1*pm2is0_m1is1, pm1is1*pm2is1_m1is1]
    expected = list(map(lambda x: int(repeat*x), expected))
    # print(expected)
    expected = np.array(expected)
    rate = np.sum(np.abs(expected - count))/repeat
    print('repeat: {rpt:d}, err rate = {rate:2.2f}%'.format(
        rpt=repeat, rate = 100*rate
    ))

test_for_repeat(1000)
test_for_repeat(1000)
test_for_repeat(1000)
test_for_repeat(1000)
test_for_repeat(5000)
test_for_repeat(5000)
test_for_repeat(5000)
test_for_repeat(5000)
test_for_repeat(10000)
test_for_repeat(10000)
test_for_repeat(10000)
test_for_repeat(10000)
test_for_repeat(100000)
test_for_repeat(100000)
test_for_repeat(100000)
test_for_repeat(100000)
