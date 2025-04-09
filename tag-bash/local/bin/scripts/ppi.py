#!/usr/bin/env python
# -*- coding: UTF-8 -*-

# 计算PPI/DPI
def calc_ppi(W, H, size):
    return ((W * W + H * H) ** 0.5) / size

def calculate_height(base: float):
    # 顶角度数为 1 角分，1 角分等于 1/60 度
    angle_deg = 1.0 / 60  # 顶角为 1 角分
    # print("顶角度数:", angle_deg)

    # 转换为弧度
    angle = angle_deg * 3.1415926 / 180
    # print("顶角弧度:", angle)

    # 通过小角度近似，计算高度
    height = base / angle
    # print("高:", height)

    return height

def get_distance(pixel_size: float) -> float:
    # 计算距离，初始单位为mm，转换为m
    # print ("像素大小:", pixel_size)
    distance = calculate_height(pixel_size) / 1000
    return distance

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

    # 参数为一个像素的大小，1 inch = 25.4 mm， 1 pixel = 25.4 / ppi mm
    distance = get_distance(25.4 / ppi)
    print(f"观看距离: {distance:.2f}m")

if __name__ == '__main__':
    __main__()
