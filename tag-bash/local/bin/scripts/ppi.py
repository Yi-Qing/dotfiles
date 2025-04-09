#!/usr/bin/env python
# -*- coding: UTF-8 -*-

'''
1. 国际视力表标准：人眼视角为万分之三弧度，约1'（角分），也即`1/60`度
2. 对于极小的顶角，等腰三角形的高约等于底边长 / 顶角对应的弧度
3. 弧度计算：角度 * pi / 180

4. dpi与ppi：`dpi * scale / ppi`越接近1，显示效果越符合程序需求
5. 常见操作系统基准dpi为96
'''

# 计算PPI/DPI
def calc_ppi(W, H, size):
    return ((W * W + H * H) ** 0.5) / size

def print_scale(ppi):
    scale = ppi / 96
    print(f"\nScale推荐(<=): {scale:.2f}")

    # dpi * scale / ppi = 1
    # scale * dpi = ppi
    # scale = ppi / dpi
    dpi = 96
    scale = (dpi * 1) / ppi
    print(f"Scale 1.00: {scale:.2f}")
    scale = (dpi * 1.25) / ppi
    print(f"Scale 1.25: {scale:.2f}")
    scale = (dpi * 1.5) / ppi
    print(f"Scale 1.50: {scale:.2f}")
    scale = (dpi * 1.75) / ppi
    print(f"Scale 1.75: {scale:.2f}")
    scale = (dpi * 2) / ppi
    print(f"Scale 2.00: {scale:.2f}")

def print_distance(ppi):
    mm = 25.4 / ppi
    m = mm / 1000
    angle = 3.0 / 10000

    print("\n不同视力推荐最小观看距离")
    distance = m / angle
    print(f"1.0/5.0: {distance:.2f}m")
    distance = m / (angle / 0.8)
    print(f"0.8/4.9: {distance:.2f}m")
    distance = m / (angle / 0.6)
    print(f"0.6/4.8: {distance:.2f}m")
    distance = m / (angle / 0.5)
    print(f"0.5/4.7: {distance:.2f}m")
    distance = m / (angle / 0.4)
    print(f"0.4/4.6: {distance:.2f}m")
    distance = m / (angle / 0.3)
    print(f"0.3/4.5: {distance:.2f}m")

# 获取参数，参数为: 分辨率W，分辨率H，大小(inch)
def __main__():
    import sys
    if len(sys.argv) != 4:
        print("Usage: python ppi.py <分辨率W> <分辨率H> <大小(inch)>")
        return
    W = int(sys.argv[1])
    H = int(sys.argv[2])
    size = float(sys.argv[3])

    ppi = calc_ppi(W, H, size)
    print(f"PPI/DPI: {ppi:.2f}")

    print_scale(ppi)

    print_distance(ppi)

if __name__ == '__main__':
    __main__()
